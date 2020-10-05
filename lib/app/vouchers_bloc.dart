import 'package:bloc_stream/bloc_stream.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';

import 'package:vouchervault/models/models.dart';

class VouchersState extends Equatable {
  VouchersState(this.vouchers);

  final IList<Voucher> vouchers;

  IList<Voucher> get sorted => vouchers.sort(order((a, b) {
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
      }));

  @override
  List<Object> get props => vouchers.toIterable().toList();

  dynamic toJson() => vouchers.map((v) => v.toJson()).toIterable().toList();

  static VouchersState fromJson(dynamic json) => VouchersState(
        ilist((json as List<dynamic>).map((j) => Voucher.fromJson(j))),
      );

  VouchersState copyWith({
    IList<Voucher> vouchers,
  }) {
    return VouchersState(
      vouchers ?? this.vouchers,
    );
  }
}

class VoucherActions {
  static final BlocStreamAction<VouchersState, VouchersBloc> Function(Voucher)
      add = (voucher) => (v, b, c) async {
            c.add(v.copyWith(
              vouchers: v.vouchers.appendElement(voucher),
            ));
          };
}

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc() : super(VouchersState(IList.from([])));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
