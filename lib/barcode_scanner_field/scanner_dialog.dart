import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/providers/providers.dart';

part 'scanner_dialog.g.dart';

@hcwidget
Widget _scannerDialog(
  WidgetRef ref, {
  required void Function(Barcode) onScan,
}) {
  final controller = ref.watch(initializedCameraController);

  final stream = ref.watch(barcodeProvider);
  useEffect(() => stream.take(1).listen(onScan).cancel, [stream]);

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: controller.maybeWhen(
      data: (c) => _PreviewDialog(controller: c),
      orElse: () => const Scaffold(
        backgroundColor: Colors.black,
      ),
    ),
  );
}

@cwidget
Widget __previewDialog(
  BuildContext context,
  WidgetRef ref, {
  required CameraController controller,
}) {
  ref.watch(flashProvider);

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            top: false,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.all(AppTheme.space3),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.add_photo_alternate),
                    onPressed: () {
                      // _chooseImage(controller)();
                    },
                  ),
                  SizedBox(width: AppTheme.space3),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(flashEnabled.notifier)
                        .update((state) => !state),
                    child: const Text('Toggle flash'),
                  ),
                  SizedBox(width: AppTheme.space3),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
