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
  const _DialogWrap({Key key, @required this.theme, @required this.child})
      : super(key: key);

  final ThemeData theme;

  final Widget child;

  @override
  Widget build(BuildContext _context) =>
      _dialogWrap(_context, theme: theme, child: child);
}

class _Barcode extends StatelessWidget {
  const _Barcode(this.type, this.data, {Key key}) : super(key: key);

  final VoucherCodeType type;

  final String data;

  @override
  Widget build(BuildContext _context) => _barcode(_context, type, data);
}
