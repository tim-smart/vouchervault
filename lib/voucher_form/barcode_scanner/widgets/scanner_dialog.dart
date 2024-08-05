import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/voucher_form/index.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'scanner_dialog.g.dart';

@hwidget
Widget _scannerDialog(
  BuildContext context, {
  required void Function(BarcodeResult) onScan,
}) {
  final scanner = useAtom(barcodeScannerAtom);
  final smartScan = useAtom(appSettings.select((a) => a.smartScan));
  final setCameraPaused = context.setAtom(cameraPaused);
  final controller = useAtom(initializedCameraController);

  // Listen for scans
  final barcodeResults = useAtom(barcodeResultProvider);
  useEffect(
    () => barcodeResults.take(1).listen(onScan).cancel,
    [barcodeResults],
  );

  // File picker
  final onPressedPicker = useCallback(() async {
    setCameraPaused(true);

    scanner
        .extractAllFromFile(smartScan)
        .tap((_) => ZIO(() => onScan(_)))
        .tapError(
          (_) => ZIO(() {
            Fluttertoast.showToast(msg: _.friendlyMessage);

            // Only un-pause on failure
            setCameraPaused(false);
          }),
        )
        .runContext(context);
  }, [onScan, smartScan, setCameraPaused]);

  // Toggle flash
  final onPressedFlash = useCallback(() {
    controller.map((c) {
      if (c.value.flashMode != FlashMode.torch) {
        c.setFlashMode(FlashMode.torch);
      } else {
        c.setFlashMode(FlashMode.off);
      }
    });
  }, [controller]);

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: _PreviewDialog(
      controller: controller.whenOrElse(data: Option.of, orElse: Option.none),
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
          controller.match(
            () => Container(color: Colors.black),
            (c) => Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: _CameraPreview(controller: c),
              ),
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
                      onPressed: onPressedPicker,
                    ),
                    ...controller.match(
                      () => [],
                      (controller) => [
                        SizedBox(width: AppTheme.space3),
                        IconButton(
                          color: Colors.white,
                          onPressed: onPressedFlash,
                          icon: _FlashIcon(controller: controller),
                        ),
                      ],
                    ),
                    SizedBox(width: AppTheme.space3),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel),
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

@hwidget
Widget __flashIcon({
  required CameraController controller,
}) {
  final mode = useListenableSelector(
    controller,
    () => controller.value.flashMode,
  );

  return mode != FlashMode.torch
      ? const Icon(Icons.flash_on)
      : const Icon(Icons.flash_off);
}
