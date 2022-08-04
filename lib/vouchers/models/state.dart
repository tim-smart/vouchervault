import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'state.freezed.dart';

@freezed
class VouchersState with _$VouchersState {
  VouchersState._();
  factory VouchersState(IList<Voucher> vouchers) = _VouchersState;

  late final IList<Voucher> sortedVouchers = vouchers.sort(_compareVoucher);

  dynamic toJson() => vouchers.toJson((v) => v.toJson());
  static VouchersState fromJson(dynamic json) => VouchersState(
        IList.fromJson(json, Voucher.fromJson),
      );
}

final _unix =
    O.map((DateTime d) => d.millisecondsSinceEpoch).c(O.getOrElse(() => 0));

int _compareVoucher(Voucher a, Voucher b) {
  final compare = a.description.compareTo(b.description);
  final expiresCompare =
      _unix(a.normalizedExpires).compareTo(_unix(b.normalizedExpires));

  return compare != 0 ? compare : expiresCompare;
}
