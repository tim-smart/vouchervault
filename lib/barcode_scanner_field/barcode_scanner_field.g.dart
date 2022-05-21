// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scanner_field.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BarcodeScannerField extends HookWidget {
  const BarcodeScannerField(
      {Key? key,
      required this.onChange,
      required this.initialValue,
      required this.barcodeType,
      required this.labelText,
      this.errorText = const None(),
      this.onScan = const None()})
      : super(key: key);

  final void Function(String) onChange;

  final String initialValue;

  final Option<Barcode> barcodeType;

  final String labelText;

  final Option<String> errorText;

  final Option<void Function(BarcodeFormat)> onScan;

  @override
  Widget build(BuildContext _context) => _barcodeScannerField(_context,
      onChange: onChange,
      initialValue: initialValue,
      barcodeType: barcodeType,
      labelText: labelText,
      errorText: errorText,
      onScan: onScan);
}

class BarcodeScannerDialog extends HookWidget {
  const BarcodeScannerDialog({Key? key, required this.onScan})
      : super(key: key);

  final void Function(BarcodeFormat, String) onScan;

  @override
  Widget build(BuildContext _context) =>
      barcodeScannerDialog(_context, onScan: onScan);
}

class _ScanButton extends StatelessWidget {
  const _ScanButton(
      {Key? key,
      required this.barcodeType,
      required this.data,
      required this.onScan})
      : super(key: key);

  final Option<Barcode> barcodeType;

  final String data;

  final void Function(BarcodeFormat, String) onScan;

  @override
  Widget build(BuildContext _context) => __scanButton(_context,
      barcodeType: barcodeType, data: data, onScan: onScan);
}
