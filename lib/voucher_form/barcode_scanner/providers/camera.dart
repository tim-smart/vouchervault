import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/either.dart' as E;
import 'package:fpdt/option.dart' as O;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

final _log = Logger('barcode_scanner_field/providers/providers.dart');

final camerasProvider = FutureProvider((ref) => availableCameras());

bool _isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = Provider((ref) => ref.watch(camerasProvider).maybeWhen(
      data: (cameras) => cameras.firstWhereOption(_isRearCamera),
      orElse: () => O.none<CameraDescription>(),
    ));

final cameraPaused = StateProvider.autoDispose((ref) => false);

final _cameraControllerProvider = Provider.autoDispose((ref) {
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
      controller.setFlashMode(FlashMode.off);

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
    (ref) => ref.watch(_cameraControllerProvider).p(O.fold(
          () => Future.any<CameraController>([]),
          (c) => c.initialize().then((_) => c),
        )));

final imageProvider = Provider.autoDispose(
    (ref) => ref.watch(initializedCameraController).maybeWhen(
          data: cameraImageStream,
          orElse: () => neverStream<CameraControllerWithImage>(),
        ));

final barcodeResultProvider =
    Provider.autoDispose.family((ref, bool enableSmartScan) {
  final ctx = ref.watch(mlContextProvider);

  return ref
      .watch(imageProvider)
      .exhaustMap(
        (t) => inputImage(t.second, camera: t.first.description)
            .p(O.map((image) => Stream.fromFuture(
                extractAll(image, embellish: enableSmartScan)(ctx)())))
            .p(O.getOrElse(() => const Stream.empty())),
      )
      .expand<BarcodeResult>(E.fold(
        (left) {
          left.when(
            barcodeNotFound: () {},
            pickerError: _log.info,
            mlkitError: _log.info,
          );

          return const [];
        },
        (r) => [r],
      ))
      .asBroadcastStream();
});
