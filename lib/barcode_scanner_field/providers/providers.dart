import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/barcode_scanner_field/providers/ml_providers.dart';
import 'package:vouchervault/barcode_scanner_field/providers/utils.dart';

final camerasProvider = FutureProvider((ref) => availableCameras());

bool isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = Provider((ref) => ref.watch(camerasProvider).maybeWhen(
      data: (cameras) => cameras.firstWhereOption(isRearCamera),
      orElse: () => O.none<CameraDescription>(),
    ));

final cameraControllerProvider =
    Provider.autoDispose((ref) => ref.watch(cameraProvider).p(O.map((camera) {
          final controller = CameraController(
            camera,
            ResolutionPreset.high,
            enableAudio: false,
          );

          ref.onDispose(() async {
            if (controller.value.isStreamingImages) {
              await controller.stopImageStream();
            }
            await controller.dispose();
          });

          return controller;
        })));

final initializedCameraController = FutureProvider.autoDispose(
    (ref) => ref.watch(cameraControllerProvider).p(O.fold(
          () => Future.any<CameraController>([]),
          (c) => c.initialize().then((value) => c),
        )));

final flashEnabled = StateProvider.autoDispose((ref) => false);

final flashProvider = Provider.autoDispose((ref) {
  final c = ref.watch(initializedCameraController);
  final enabled = ref.watch(flashEnabled);

  c.whenData((c) => c.setFlashMode(enabled ? FlashMode.torch : FlashMode.off));
});

final imageProvider = Provider.autoDispose(
    (ref) => ref.watch(initializedCameraController).maybeWhen(
          data: cameraImageStream,
          orElse: () => neverStream<CameraControllerWithImage>(),
        ));

final barcodeProvider = Provider.autoDispose((ref) {
  final scanner = ref.watch(barcodeScannerProvider);
  final textRecognizer = ref.watch(textRecognizerProvider);
  final entityExtractor = ref.watch(entityRecognizerProvider);

  return ref
      .watch(imageProvider)
      .exhaustMap(
        (t) => inputImage(t.second, camera: t.first.description).p(O.fold(
          () => const Stream.empty() as Stream<List<Barcode>>,
          (image) => Stream.fromFuture(processInputImage(
            image,
            barcodeScanner: scanner,
            textRecognizer: textRecognizer,
            entityExtractor: entityExtractor,
          )),
        )),
      )
      .expand((b) => b);
});
