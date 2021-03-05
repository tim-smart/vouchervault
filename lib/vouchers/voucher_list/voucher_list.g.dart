// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_list.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class VoucherList extends StatelessWidget {
  const VoucherList({Key? key, required this.vouchers, required this.onPressed})
      : super(key: key);

  final List<Voucher> vouchers;

  final void Function(Voucher) onPressed;

  @override
  Widget build(BuildContext _context) =>
      voucherList(vouchers: vouchers, onPressed: onPressed);
}
