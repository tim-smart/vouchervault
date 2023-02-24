import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_elemental/flutter_elemental.dart' hide Logger;
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/app/atoms.dart';
import 'package:vouchervault/voucher_form/index.dart';

final _log = Logger('barcode_scanner_field/providers/providers.dart');
final cameras = futureAtom((get) => availableCameras());

bool _isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = atom((get) => get(cameras).whenOrElse(
      data: (cameras) => cameras.where(_isRearCamera).head,
      orElse: () => Option<CameraDescription>.none(),
    )).keepAlive();

final cameraPaused = stateAtom(false);

final _cameraControllerProvider = atom((get) {
  final paused = get(cameraPaused);
  final camera = get(cameraProvider);

  return camera.filter((_) => !paused).map((camera) {
    final controller = CameraController(
      camera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    get.onDispose(() async {
      await controller.setFlashMode(FlashMode.off);

      if (controller.value.isStreamingImages) {
        try {
          await controller.stopImageStream();
        } catch (_) {}
      }
      await controller.dispose();
    });

    return controller;
  });
});

final initializedCameraController =
    futureAtom((get) => get(_cameraControllerProvider).fold(
          () => Future.any<CameraController>([]),
          (c) => c.initialize().then((_) => c),
        ));

final imageProvider = atom((get) => get(initializedCameraController).whenOrElse(
      data: (_) => cameraImageStream(_),
      orElse: () => neverStream<CameraControllerWithImage>(),
    ));

final barcodeResultProvider = atom((get) {
  final scanner = get(barcodeScannerAtom);
  final smartScan = get(appSettings.select((a) => a.smartScan));

  return get(imageProvider)
      .exhaustMap(
        (t) => inputImage(
          t.second,
          camera: t.first.description,
        ).fold<Stream<Either<MlError, BarcodeResult>>>(
          () => const Stream.empty(),
          (image) => Stream.fromFuture(
            scanner
                .extractAll(image, embellish: smartScan)
                .either
                .runFutureOrThrow(),
          ),
        ),
      )
      .expand<BarcodeResult>((_) => _.fold(
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
