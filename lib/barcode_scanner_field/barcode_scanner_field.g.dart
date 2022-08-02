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
      this.onScan = const None(),
      this.launchScannerImmediately = false})
      : super(key: key);

  final void Function(String) onChange;

  final String initialValue;

  final Option<Barcode> barcodeType;

  final String labelText;

  final Option<String> errorText;

  final Option<void Function(BarcodeResult)> onScan;

  final bool launchScannerImmediately;

  @override
  Widget build(BuildContext _context) => _barcodeScannerField(_context,
      onChange: onChange,
      initialValue: initialValue,
      barcodeType: barcodeType,
      labelText: labelText,
      errorText: errorText,
      onScan: onScan,
      launchScannerImmediately: launchScannerImmediately);
}

class _BarcodeButton extends StatelessWidget {
  const _BarcodeButton(
      {Key? key,
      required this.barcodeType,
      required this.data,
      required this.onPressed})
      : super(key: key);

  final Option<Barcode> barcodeType;

  final String data;

  final void Function() onPressed;

  @override
  Widget build(BuildContext _context) => __barcodeButton(_context,
      barcodeType: barcodeType, data: data, onPressed: onPressed);
}
