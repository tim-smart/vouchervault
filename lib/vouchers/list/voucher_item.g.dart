// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_item.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class VoucherItem extends StatelessWidget {
  const VoucherItem({
    Key? key,
    required this.voucher,
    required this.onPressed,
    this.bottomPadding = 0,
  }) : super(key: key);

  final Voucher voucher;

  final void Function() onPressed;

  final double bottomPadding;

  @override
  Widget build(BuildContext _context) => voucherItem(
        _context,
        voucher: voucher,
        onPressed: onPressed,
        bottomPadding: bottomPadding,
      );
}
