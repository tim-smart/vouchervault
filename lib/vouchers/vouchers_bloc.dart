import 'dart:convert';

import 'package:bloc_stream/bloc_stream.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_bloc_stream/riverpod_bloc_stream.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/lib/files.dart' as files;
import 'package:vouchervault/models/voucher.dart';

part 'vouchers_bloc.freezed.dart';

final _uuidgen = Uuid();

final vouchersProvider = BlocStreamProvider<VouchersBloc, VouchersState>(
  (ref) => VouchersBloc()..add(VoucherActions.removeExpired()),
);

final voucherProvider = Provider.autoDispose.family((ref, String uuid) {
  final state = ref.watch(vouchersProvider);
  return optionOf(state.vouchers.firstWhereOrNull((v) => v.uuid == uuid));
});

@freezed
class VouchersState with _$VouchersState {
  VouchersState._();
  factory VouchersState(List<Voucher> vouchers) = _VouchersState;

  late final List<Voucher> sortedVouchers = vouchers.sorted((a, b) {
    final compare = a.description.compareTo(b.description);
    final expiresCompare = a.expiresOption
        .map((d) => d.millisecondsSinceEpoch)
        .getOrElse(() => 0)
        .compareTo(b.expiresOption
            .map((d) => d.millisecondsSinceEpoch)
            .getOrElse(() => 0));

    return compare != 0 ? compare : expiresCompare;
  });

  dynamic toJson() => vouchers.map((v) => v.toJson()).toList();
  static VouchersState fromJson(dynamic json) => VouchersState(
        (json as List<dynamic>).map((j) => Voucher.fromJson(j)).toList(),
      );
}

typedef VoucherAction = Action<VouchersBloc, VouchersState>;

class VoucherActions {
  static VoucherAction removeExpired() => (b, add) => add(b.value.copyWith(
        vouchers: b.value.vouchers.fold<List<Voucher>>(
          [],
          (acc, v) => (v.removeOnceExpired &&
                  v.expiresOption
                      .map(endOfDay)
                      .map((expires) => expires.isBefore(DateTime.now()))
                      .getOrElse(() => false))
              ? acc
              : [...acc, v],
        ),
      ));

  static VoucherAction add(Voucher voucher) =>
      (b, add) => add(b.value.copyWith(vouchers: [
            ...b.value.vouchers,
            voucher.copyWith(uuid: _uuidgen.v4()),
          ]));

  static VoucherAction update(Voucher voucher) =>
      (b, add) => add(b.value.copyWith(
            vouchers: b.value.vouchers
                .map((v) => v.uuid == voucher.uuid ? voucher : v)
                .toList(),
          ));

  static VoucherAction Function(Option<String>) maybeUpdateBalance(Voucher v) =>
      (s) => (b, add) => s
          .bind((s) => catching(() => double.parse(s)).toOption())
          .map((amount) => (amount * 1000).round())
          .bind((amount) => v.balanceOption.map((balance) => balance - amount))
          .map((balance) => update(v.copyWith(balanceMilliunits: balance)))
          .map((action) => action(b, add));

  static VoucherAction remove(Voucher voucher) =>
      (b, add) => add(b.value.copyWith(
            vouchers:
                b.value.vouchers.where((v) => v.uuid != voucher.uuid).toList(),
          ));

  static VoucherAction import() =>
      (b, add) => files.pick(['json']).then((r) => r
          .map((r) => String.fromCharCodes(r.value2))
          .bind((json) => catching(() => jsonDecode(json)).toOption())
          .bind(optionOf)
          .map((json) => VouchersState.fromJson(json))
          .map(add));

  static VoucherAction export() => (b, add) => files
      .writeString('vouchervault.json', jsonEncode(b.value.toJson()))
      .then((file) => Share.shareFiles(
            [file.path],
            subject: "VoucherVault export",
          ));
}

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc([VouchersState? initialState])
      : super(initialState ?? VouchersState([]));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
