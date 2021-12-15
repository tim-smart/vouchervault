import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_either.dart' as TE;
import 'package:fpdt/tuple.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:riverpod_bloc_stream/riverpod_bloc_stream.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/lib/files.dart' as files;
import 'package:vouchervault/lib/milliunits.dart' as millis;
import 'package:vouchervault/models/voucher.dart';

part 'vouchers_bloc.freezed.dart';

final vouchersProvider =
    BlocStreamProvider<VouchersBloc, VouchersState>((ref) => VouchersBloc());

final voucherProvider = Provider.autoDispose.family((ref, String uuid) {
  final state = ref.watch(vouchersProvider);
  return O.fromNullable(state.vouchers.firstWhereOrNull((v) => v.uuid == uuid));
});

final _uuidgen = Uuid();

final _unix = O
    .map((DateTime d) => d.millisecondsSinceEpoch)
    .compose(O.getOrElse(() => 0));

@freezed
class VouchersState with _$VouchersState {
  VouchersState._();
  factory VouchersState(IList<Voucher> vouchers) = _VouchersState;

  late final IList<Voucher> sortedVouchers = vouchers.sort((a, b) {
    final compare = a.description.compareTo(b.description);
    final expiresCompare =
        _unix(a.expiresOption).compareTo(_unix(b.expiresOption));

    return compare != 0 ? compare : expiresCompare;
  });

  dynamic toJson() => vouchers.toJson((v) => v.toJson());
  static VouchersState fromJson(dynamic json) => VouchersState(
        (json as List).map((j) => Voucher.fromJson(j)).toIList(),
      );
}

typedef VouchersAction = BlocStreamAction<VouchersState>;

VouchersAction removeExpiredVouchers() => (value, add) => add(value.copyWith(
      vouchers: value.vouchers.fold(
        value.vouchers,
        (acc, v) => v.expiresOption
            .chain(O.filter((expires) => expires.isBefore(DateTime.now())))
            .chain(O.fold(
              () => acc,
              (_) => acc.remove(v),
            )),
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

VouchersAction Function(O.Option<String>) maybeUpdateVoucherBalance(
  Voucher v,
) =>
    (s) => (value, add) => s
        .chain(O.flatMap(millis.fromString))
        .chain((amount) => tuple2(amount, v.balanceOption))
        .chain(O.mapTuple2((amount, balance) => balance - amount))
        .chain(O.map((balance) =>
            updateVoucher(v.copyWith(balanceMilliunits: balance))(value, add)));

VouchersAction removeVoucher(Voucher voucher) =>
    (value, add) => add(value.copyWith(
          vouchers: value.vouchers.removeWhere((v) => v.uuid == voucher.uuid),
        ));

VouchersAction importVouchers() => (b, add) => files
    .pick(['json'])
    .chain(TE.map((r) => String.fromCharCodes(r.second)))
    .chain(TE.chainTryCatchK(
      jsonDecode,
      (error, _stackTrace) => 'Could not parse import JSON: $error',
    ))
    .chain(TE.chainNullableK(() => 'Import was null'))
    .chain(TE.map((json) => VouchersState.fromJson(json)))
    .chain(TE.map(add))
    .chain(TE.getOrElse((msg) => print("vouchers_bloc.dart: $msg")))();

VouchersAction exportVouchers() => (value, add) => files
    .writeString('vouchervault.json', jsonEncode(value.toJson()))
    .then((file) => Share.shareFiles(
          [file.path],
          subject: "VoucherVault export",
        ));

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc({VouchersState? initialValue})
      : super(initialValue ?? VouchersState(IList()));

  @override
  dynamic toJson(value) => value.toJson();

  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
