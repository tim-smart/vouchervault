import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/either.dart' as E;
import 'package:fpdt/option.dart' as O;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/barcode_scanner_field/providers/barcode_result.dart';
import 'package:vouchervault/barcode_scanner_field/providers/ml_providers.dart';
import 'package:vouchervault/barcode_scanner_field/providers/ops.dart';
import 'package:vouchervault/barcode_scanner_field/lib/camera_utils.dart';

final _log = Logger('barcode_scanner_field/providers/providers.dart');

final camerasProvider = FutureProvider((ref) => availableCameras());

bool isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = Provider((ref) => ref.watch(camerasProvider).maybeWhen(
      data: (cameras) => cameras.firstWhereOption(isRearCamera),
      orElse: () => O.none<CameraDescription>(),
    ));

final cameraPaused = StateProvider.autoDispose((ref) => false);

final cameraControllerProvider = Provider.autoDispose((ref) {
  final paused = ref.watch(cameraPaused);

  return ref
      .watch(cameraProvider)
      .p(O.filter((_) => !paused))
      .p(O.map((camera) {
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    ref.onDispose(() async {
      if (controller.value.isStreamingImages) {
        try {
          await controller.stopImageStream();
        } catch (_) {}
      }
      await controller.dispose();
    });

    return controller;
  }));
});

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

final mlContextProvider = Provider.autoDispose((ref) => MlContext(
      textRecognizer: ref.watch(textRecognizerProvider),
      barcodeScanner: ref.watch(barcodeScannerProvider),
      entityExtractor: ref.watch(entityRecognizerProvider),
    ));

final barcodeResultProvider = Provider.autoDispose((ref) {
  final c = ref.watch(mlContextProvider);

  return ref
      .watch(imageProvider)
      .exhaustMap(
        (t) => inputImage(t.second, camera: t.first.description)
            .p(O.map((image) => Stream.fromFuture(extractAll(image)(c)())))
            .p(O.getOrElse(() => const Stream.empty())),
      )
      .expand<BarcodeResult>(E.fold(
        (left) {
          _log.info(left);
          return const [];
        },
        (r) => [r],
      ))
      .asBroadcastStream();
});
