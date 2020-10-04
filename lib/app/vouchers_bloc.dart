import 'package:bloc_stream/bloc_stream.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';

import 'package:vouchervault/models/models.dart';

class VouchersState extends Equatable {
  VouchersState(this.vouchers);

  final IVector<Voucher> vouchers;

  @override
  List<Object> get props => vouchers.toIterable().toList();

  dynamic toJson() => vouchers.map((v) => v.toJson()).toIterable().toList();

  static VouchersState fromJson(dynamic json) => VouchersState(
        ivector((json as List<dynamic>).map((j) => Voucher.fromJson(j))),
      );

  VouchersState copyWith({
    IVector<Voucher> vouchers,
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
  VouchersBloc() : super(VouchersState(emptyVector()));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
