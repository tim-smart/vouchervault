// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class VoucherDialog extends HookWidget {
  const VoucherDialog(
      {Key key,
      @required this.voucher,
      @required this.onEdit,
      @required this.onClose,
      @required this.onRemove,
      @required this.onSpend})
      : super(key: key);

  final Voucher voucher;

  final void Function(Voucher) onEdit;

  final void Function() onClose;

  final void Function(Voucher) onRemove;

  final void Function(Voucher) onSpend;

  @override
  Widget build(BuildContext _context) => voucherDialog(_context,
      voucher: voucher,
      onEdit: onEdit,
      onClose: onClose,
      onRemove: onRemove,
      onSpend: onSpend);
}
