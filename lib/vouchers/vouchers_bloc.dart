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
}

class VoucherActions {}

class VouchersBloc extends PersistedBlocStream<VouchersState> {
  VouchersBloc() : super(VouchersState(emptyVector()));

  @override
  dynamic toJson(VouchersState value) => value.toJson();
  @override
  VouchersState fromJson(json) => VouchersState.fromJson(json);
}
