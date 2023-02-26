// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scanner_field.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BarcodeScannerField extends HookWidget {
  const BarcodeScannerField({
    Key? key,
    required this.onChange,
    required this.initialValue,
    required this.barcodeType,
    required this.labelText,
    this.errorText = const Option.none(),
    this.onScan = const Option.none(),
    this.launchScannerImmediately = false,
  }) : super(key: key);

  final void Function(String) onChange;

  final String initialValue;

  final Option<Barcode> barcodeType;

  final String labelText;

  final Option<String> errorText;

  final Option<void Function(BarcodeResult)> onScan;

  final bool launchScannerImmediately;

  @override
  Widget build(BuildContext _context) => _barcodeScannerField(
        _context,
        onChange: onChange,
        initialValue: initialValue,
        barcodeType: barcodeType,
        labelText: labelText,
        errorText: errorText,
        onScan: onScan,
        launchScannerImmediately: launchScannerImmediately,
      );
}
