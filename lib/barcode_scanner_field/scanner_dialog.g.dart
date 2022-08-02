// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ScannerDialog extends HookConsumerWidget {
  const ScannerDialog({Key? key, required this.onScan}) : super(key: key);

  final void Function(BarcodeResult) onScan;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      _scannerDialog(_ref, onScan: onScan);
}

class _PreviewDialog extends ConsumerWidget {
  const _PreviewDialog(
      {Key? key, required this.controller, required this.onPressedPicker})
      : super(key: key);

  final Option<CameraController> controller;

  final void Function() onPressedPicker;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      __previewDialog(_context, _ref,
          controller: controller, onPressedPicker: onPressedPicker);
}
