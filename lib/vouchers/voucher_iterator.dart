import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:offset_iterator_persist/offset_iterator_persist.dart';
import 'package:offset_iterator_riverpod/offset_iterator_riverpod.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/lib/and_then.dart';
import 'package:vouchervault/lib/files.dart' as files;
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/voucher.dart';

part 'voucher_iterator.freezed.dart';

final voucherIteratorProvider = Provider((ref) => voucherIterator(
      storage: ref.watch(storageProvider),
    ).andThen(stateIteratorProvider(ref)));

final vouchersProvider = Provider((ref) => ref
    .watch(voucherIteratorProvider)
    .andThen(stateIteratorValueProvider(ref)));

final voucherProvider = Provider.autoDispose.family((ref, String uuid) {
  final state = ref.watch(vouchersProvider);
  return optionOf(state.vouchers.firstWhereOrNull((v) => v.uuid == uuid));
});

final _uuidgen = Uuid();

@freezed
class VouchersState with _$VouchersState {
  VouchersState._();
  factory VouchersState(IList<Voucher> vouchers) = _VouchersState;

  late final IList<Voucher> sortedVouchers = vouchers.sort((a, b) {
    final compare = a.description.compareTo(b.description);
    final expiresCompare = a.expiresOption
        .map((d) => d.millisecondsSinceEpoch)
        .getOrElse(() => 0)
        .compareTo(b.expiresOption
            .map((d) => d.millisecondsSinceEpoch)
            .getOrElse(() => 0));

    return compare != 0 ? compare : expiresCompare;
  });

  dynamic toJson() => vouchers.toJson((v) => v.toJson());
  static VouchersState fromJson(dynamic json) => VouchersState(
        (json as List).map((j) => Voucher.fromJson(j)).toIList(),
      );
}

StateIterator<VouchersState> voucherIterator({
  required Storage storage,
  VouchersState? initialState,
}) =>
    StateIterator(
      name: 'voucherIterator',
      initialState: initialState ?? VouchersState(IList()),
      transform: (parent) => parent.persist(
        storage: storage,
        key: 'voucherIterator',
        toJson: (s) => s.toJson(),
        fromJson: VouchersState.fromJson,
      ),
    );

typedef VouchersAction = StateIteratorAction<VouchersState>;

VouchersAction removeExpiredVouchers() => (value, add) => add(value.copyWith(
      vouchers: value.vouchers.fold(
        value.vouchers,
        (acc, v) => v.expiresOption
            .filter((_) => v.removeOnceExpired)
            .map(endOfDay)
            .filter((expires) => expires.isBefore(DateTime.now()))
            .match(
              (_) => acc.remove(v),
              () => acc,
            ),
      ),
    ));

VouchersAction addVoucher(Voucher voucher) =>
    (value, add) => add(value.copyWith(
          vouchers: value.vouchers.add(voucher.copyWith(uuid: _uuidgen.v4())),
        ));

VouchersAction updateVoucher(Voucher voucher) =>
    (value, add) => add(value.copyWith(
          vouchers: value.vouchers.updateById([voucher], (v) => v.uuid),
        ));

VouchersAction Function(Option<String>) maybeUpdateVoucherBalance(Voucher v) =>
    (s) => (value, add) => s
        .flatMap((s) => Option.tryCatch(() => double.parse(s)))
        .map((amount) => (amount * 1000).round())
        .flatMap((amount) => v.balanceOption.map((balance) => balance - amount))
        .map((balance) => updateVoucher(v.copyWith(balanceMilliunits: balance)))
        .map((action) => action(value, add));

VouchersAction removeVoucher(Voucher voucher) =>
    (value, add) => add(value.copyWith(
          vouchers: value.vouchers.removeWhere((v) => v.uuid == voucher.uuid),
        ));

VouchersAction importVouchers() => (b, add) => files
    .pick(['json'])
    .map((r) => String.fromCharCodes(r.second))
    .flatMap(TaskEither.tryCatchK(
      (json) async => jsonDecode(json),
      (error, _stackTrace) => 'Could not parse import JSON: $error',
    ))
    .flatMap((r) => TaskEither.fromOption(
          optionOf(r),
          () => 'Import was null',
        ))
    .map((json) => VouchersState.fromJson(json))
    .map(add)
    .getOrElse((msg) => print("vouchers_bloc.dart: $msg"))
    .run();

VouchersAction exportVouchers() => (value, add) => files
    .writeString('vouchervault.json', jsonEncode(value.toJson()))
    .then((file) => Share.shareFiles(
          [file.path],
          subject: "VoucherVault export",
        ));
