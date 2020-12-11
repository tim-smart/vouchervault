import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:vouchervault/lib/lib.dart';

import 'package:vouchervault/models/models.dart';

class VouchersState extends Equatable {
  VouchersState(this.vouchers) {
    vouchers.sort((a, b) {
      final compare = a.description.compareTo(b.description);
      final expiresCompare = a.expiresOption
          .map((d) => d.millisecondsSinceEpoch)
          .getOrElse(() => 0)
          .compareTo(b.expiresOption
              .map((d) => d.millisecondsSinceEpoch)
              .getOrElse(() => 0));

      return compare != 0 ? compare : expiresCompare;
    });
  }

  final List<Voucher> vouchers;

  @override
  List<Object> get props => vouchers;

  dynamic toJson() => vouchers.map((v) => v.toJson()).toList();
  static VouchersState fromJson(dynamic json) => VouchersState(
        (json as List<dynamic>).map((j) => Voucher.fromJson(j)).toList(),
      );

  VouchersState copyWith({List<Voucher> vouchers}) =>
      VouchersState(vouchers ?? this.vouchers);
}

typedef VoucherAction = Future<void> Function(
    VouchersBloc, void Function(VouchersState));

class VoucherActions {
  static final VoucherAction init = (b, add) async => add(b.value.copyWith(
        vouchers: b.value.vouchers.fold(
          <Voucher>[],
          (acc, v) => (v.removeOnceExpired &&
                  v.expiresOption
                      .map(endOfDay)
                      .map((expires) => expires.isBefore(DateTime.now()))
                      .getOrElse(() => false))
              ? acc
              : [...acc, v],
        ),
      ));

  static VoucherAction add(Voucher voucher) => (b, add) async {
        add(b.value.copyWith(vouchers: [
          ...b.value.vouchers,
          voucher,
        ]));
      };

  static VoucherAction update(Voucher voucher) => (b, add) async {
        add(b.value.copyWith(
          vouchers: b.value.vouchers
              .map((v) => v.uuid == voucher.uuid ? voucher : v)
              .toList(),
        ));
      };

  static VoucherAction Function(Option<String>) maybeUpdateBalance(Voucher v) =>
      (s) => (b, add) => s
          .bind((s) => catching(() => double.parse(s)).toOption())
          .bind((amount) => v.balanceOption.map((balance) => balance - amount))
          .map((balance) => update(v.copyWith(balance: some(balance))))
          .fold(() => Future.value(), (action) => action(b, add));

  static VoucherAction remove(Voucher voucher) => (b, add) async {
        add(b.value.copyWith(
          vouchers:
              b.value.vouchers.where((v) => v.uuid != voucher.uuid).toList(),
        ));
      };
}

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc() : super(VouchersState([]));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
