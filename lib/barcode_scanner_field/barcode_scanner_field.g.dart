// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scanner_field.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class _ScanButton extends StatelessWidget {
  const _ScanButton(this.barcodeType, this.data, this.onScan, {Key key})
      : super(key: key);

  final Option<Barcode> barcodeType;

  final String data;

  final void Function(ScanResult) onScan;

  @override
  Widget build(BuildContext _context) =>
      _scanButton(_context, barcodeType, data, onScan);
}
