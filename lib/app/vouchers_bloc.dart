import 'package:bloc_stream/bloc_stream.dart';
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

class VoucherActions {
  static final BlocStreamAction<VouchersState, VouchersBloc> init =
      (v, b, c) async {
    c.add(v.copyWith(
      vouchers: v.vouchers.fold(
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
  };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      add = (voucher) => (v, b, c) async {
            c.add(v.copyWith(vouchers: [
              ...v.vouchers,
              voucher,
            ]));
          };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      update = (voucher) => (v, b, c) async {
            c.add(v.copyWith(
              vouchers: v.vouchers
                  .map((v) => v.uuid == voucher.uuid ? voucher : v)
                  .toList(),
            ));
          };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      remove = (voucher) => (v, b, c) async {
            c.add(v.copyWith(
              vouchers:
                  v.vouchers.where((v) => v.uuid != voucher.uuid).toList(),
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
