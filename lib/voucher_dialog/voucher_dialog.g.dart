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

class _DialogWrap extends StatelessWidget {
  const _DialogWrap(this.color, this.child, {Key key}) : super(key: key);

  final Color color;

  final Widget child;

  @override
  Widget build(BuildContext _context) => _dialogWrap(_context, color, child);
}

class _Barcode extends StatelessWidget {
  const _Barcode(this.barcode, this.data, {Key key}) : super(key: key);

  final Barcode barcode;

  final String data;

  @override
  Widget build(BuildContext _context) => _barcode(_context, barcode, data);
}
