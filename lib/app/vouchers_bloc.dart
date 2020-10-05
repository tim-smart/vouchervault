import 'package:bloc_stream/bloc_stream.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:time/time.dart';
import 'package:vouchervault/lib/lib.dart';

import 'package:vouchervault/models/models.dart';

final _vouchersOrder = order<Voucher>((a, b) {
  final compare = a.description.compareTo(b.description);
  final expiresCompare = a.expiresOption
      .map((d) => d.millisecondsSinceEpoch)
      .getOrElse(() => 0)
      .compareTo(b.expiresOption
          .map((d) => d.millisecondsSinceEpoch)
          .getOrElse(() => 0));

  if (compare == 0) {
    return expiresCompare > 0
        ? Ordering.GT
        : (expiresCompare < 0 ? Ordering.LT : Ordering.EQ);
  } else if (compare > 0) {
    return Ordering.GT;
  }

  return Ordering.LT;
});

class VouchersState extends Equatable {
  VouchersState.fromIterable(Iterable<Voucher> vouchers)
      : vouchers = isetWithOrder(_vouchersOrder, vouchers);
  VouchersState(this.vouchers);

  final ISet<Voucher> vouchers;

  @override
  List<Object> get props => vouchers.toIterable().toList();

  dynamic toJson() => vouchers.toIterable().map((v) => v.toJson()).toList();
  static VouchersState fromJson(dynamic json) => VouchersState.fromIterable(
        (json as List<dynamic>).map((j) => Voucher.fromJson(j)),
      );

  VouchersState copyWith({ISet<Voucher> vouchers}) =>
      VouchersState(vouchers ?? this.vouchers);
}

class VoucherActions {
  static final BlocStreamAction<VouchersState, VouchersBloc> init =
      (v, b, c) async {
    c.add(v.copyWith(
      vouchers: v.vouchers.foldLeft(
        isetWithOrder(_vouchersOrder, <Voucher>[]),
        (acc, v) => v.expiresOption
                .map(endOfDay)
                .map((expires) => expires.isBefore(1.days.ago))
                .getOrElse(() => false)
            ? acc
            : acc.insert(v),
      ),
    ));
  };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      add = (voucher) => (v, b, c) async {
            c.add(v.copyWith(vouchers: v.vouchers.insert(voucher)));
          };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      update = (voucher) => (v, b, c) async {
            c.add(v.copyWith(
              vouchers: v.vouchers.transform<Voucher>(
                _vouchersOrder,
                (v) => v.uuid == voucher.uuid ? voucher : v,
              ),
            ));
          };

  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      remove = (voucher) => (v, b, c) async {
            c.add(v.copyWith(
              vouchers: v.vouchers.filter((v) => v.uuid != voucher.uuid),
            ));
          };
}

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc() : super(VouchersState.fromIterable([]));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
