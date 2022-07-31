// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ScannerDialog extends HookConsumerWidget {
  const ScannerDialog({Key? key, required this.onScan}) : super(key: key);

  final void Function(Barcode) onScan;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      _scannerDialog(_ref, onScan: onScan);
}

class _PreviewDialog extends ConsumerWidget {
  const _PreviewDialog({Key? key, required this.controller}) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext _context, WidgetRef _ref) =>
      __previewDialog(_context, _ref, controller: controller);
}
