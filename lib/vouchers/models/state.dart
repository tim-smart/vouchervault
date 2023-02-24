import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vouchervault/vouchers/index.dart';

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

int _unix(Option<DateTime> dt) =>
    dt.map((d) => d.millisecondsSinceEpoch).getOrElse(() => 0);

int _compareVoucher(Voucher a, Voucher b) {
  final compare = a.description.compareTo(b.description);
  final expiresCompare =
      _unix(a.normalizedExpires).compareTo(_unix(b.normalizedExpires));

  return compare != 0 ? compare : expiresCompare;
}
