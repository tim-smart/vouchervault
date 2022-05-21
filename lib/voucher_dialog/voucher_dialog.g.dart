// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class VoucherDialog extends StatelessWidget {
  const VoucherDialog(
      {Key? key,
      required this.voucher,
      required this.onTapBarcode,
      required this.onEdit,
      required this.onClose,
      required this.onRemove,
      required this.onSpend})
      : super(key: key);

  final Voucher voucher;

  final void Function() onTapBarcode;

  final void Function() onEdit;

  final void Function() onClose;

  final void Function() onRemove;

  final void Function() onSpend;

  @override
  Widget build(BuildContext _context) => _voucherDialog(_context,
      voucher: voucher,
      onTapBarcode: onTapBarcode,
      onEdit: onEdit,
      onClose: onClose,
      onRemove: onRemove,
      onSpend: onSpend);
}

class _DialogWrap extends StatelessWidget {
  const _DialogWrap({Key? key, required this.theme, required this.child})
      : super(key: key);

  final ThemeData theme;

  final Widget child;

  @override
  Widget build(BuildContext _context) =>
      __dialogWrap(_context, theme: theme, child: child);
}

class _Barcode extends StatelessWidget {
  const _Barcode(
      {Key? key, required this.type, required this.data, required this.onTap})
      : super(key: key);

  final VoucherCodeType type;

  final String data;

  final void Function() onTap;

  @override
  Widget build(BuildContext _context) =>
      __barcode(_context, type: type, data: data, onTap: onTap);
}
