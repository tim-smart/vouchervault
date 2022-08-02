import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/barcode_scanner_field/providers/barcode_result.dart';
import 'package:vouchervault/barcode_scanner_field/providers/ops.dart';
import 'package:vouchervault/barcode_scanner_field/providers/providers.dart';

part 'scanner_dialog.g.dart';

@hcwidget
Widget _scannerDialog(
  WidgetRef ref, {
  required void Function(BarcodeResult) onScan,
}) {
  final controller = ref.watch(initializedCameraController);

  final stream = ref.watch(barcodeResultProvider.stream);
  useEffect(() => stream.take(1).listen(onScan).cancel, [stream]);

  final mlContext = ref.watch(mlContextProvider);
  final onPressedPicker = useCallback(() {
    extractAllFromFile.p(RTE.tap(onScan))(mlContext)();
  }, [onScan, mlContext]);

  return AnnotatedRegion(
    value: SystemUiOverlayStyle.light,
    child: _PreviewDialog(
      controller: controller.maybeWhen(data: O.some, orElse: O.none),
      onPressedPicker: onPressedPicker,
    ),
  );
}

@cwidget
Widget __previewDialog(
  BuildContext context,
  WidgetRef ref, {
  required Option<CameraController> controller,
  required void Function() onPressedPicker,
}) {
  ref.watch(flashProvider);

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: [
        controller.p(O.fold(
          () => Container(color: Colors.black),
          (c) => Positioned.fill(
            child: AspectRatio(
              aspectRatio: c.value.aspectRatio,
              child: CameraPreview(c),
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
