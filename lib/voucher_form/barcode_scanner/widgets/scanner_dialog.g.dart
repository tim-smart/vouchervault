// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ScannerDialog extends HookWidget {
  const ScannerDialog({
    Key? key,
    required this.onScan,
  }) : super(key: key);

  final void Function(BarcodeResult) onScan;

  @override
  Widget build(BuildContext _context) => _scannerDialog(
        _context,
        onScan: onScan,
      );
}

class _PreviewDialog extends StatelessWidget {
  const _PreviewDialog({
    Key? key,
    required this.controller,
    required this.onPressedPicker,
    required this.onPressedFlash,
  }) : super(key: key);

  final Option<CameraController> controller;

  final void Function() onPressedPicker;

  final void Function() onPressedFlash;

  @override
  Widget build(BuildContext _context) => __previewDialog(
        _context,
        controller: controller,
        onPressedPicker: onPressedPicker,
        onPressedFlash: onPressedFlash,
      );
}

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext _context) =>
      __cameraPreview(controller: controller);
}

class _FlashIcon extends HookWidget {
  const _FlashIcon({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext _context) => __flashIcon(controller: controller);
}
