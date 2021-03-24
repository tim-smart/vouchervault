// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scanner_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BarcodeScannerDialog extends HookWidget {
  const BarcodeScannerDialog({Key? key, required this.onScan})
      : super(key: key);

  final void Function(BarcodeFormat, String) onScan;

  @override
  Widget build(BuildContext _context) =>
      barcodeScannerDialog(_context, onScan: onScan);
}
