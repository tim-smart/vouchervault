import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/voucher_form/barcode_scanner/models/barcode_result.dart';
import 'package:vouchervault/voucher_form/barcode_scanner/providers/ml_providers.dart';
import 'package:vouchervault/voucher_form/barcode_scanner/ops.dart';
import 'package:vouchervault/voucher_form/barcode_scanner/providers/providers.dart';

part 'scanner_dialog.g.dart';

@hcwidget
Widget _scannerDialog(
  WidgetRef ref, {
  required bool enableSmartScan,
  required void Function(BarcodeResult) onScan,
}) {
  final controller = ref.watch(initializedCameraController);

  // Listen for scans
  final barcodeResults = ref.watch(barcodeResultProvider(enableSmartScan));
  useEffect(
    () => barcodeResults.take(1).listen(onScan).cancel,
    [barcodeResults],
  );

  // File picker
  final mlContext = ref.watch(mlContextProvider);
  final onPressedPicker = useCallback(() async {
    ref.read(cameraPaused.notifier).state = true;

    extractAllFromFile(enableSmartScan).p(RTE.tap(onScan)).p(RTE.tapLeft((err) {
      Fluttertoast.showToast(msg: err.friendlyMessage);

      // Only un-pause on failure
      ref.read(cameraPaused.notifier).state = false;
    }))(mlContext)();
  }, [onScan, mlContext, enableSmartScan]);

  // Toggle flash
  final onPressedFlash = useCallback(() {
    controller.whenData((c) {
      if (c.value.flashMode == FlashMode.off) {
        c.setFlashMode(FlashMode.torch);
      } else {
        c.setFlashMode(FlashMode.off);
      }
    });
  }, [controller]);

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: _PreviewDialog(
      controller: controller.maybeWhen(data: O.some, orElse: O.none),
      onPressedPicker: onPressedPicker,
      onPressedFlash: onPressedFlash,
    ),
  );
}

@swidget
Widget __previewDialog(
  BuildContext context, {
  required Option<CameraController> controller,
  required void Function() onPressedPicker,
  required void Function() onPressedFlash,
}) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          controller.p(O.fold(
            () => Container(color: Colors.black),
            (c) => Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: _CameraPreview(controller: c),
              ),
            ),
          )),
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
                      onPressed: onPressedPicker,
                    ),
                    SizedBox(width: AppTheme.space3),
                    ElevatedButton(
                      onPressed: onPressedFlash,
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

@swidget
Widget __cameraPreview({
  required CameraController controller,
}) =>
    SizedBox(
      height: controller.value.previewSize!.width,
      width: controller.value.previewSize!.height,
      child: controller.buildPreview(),
    );
