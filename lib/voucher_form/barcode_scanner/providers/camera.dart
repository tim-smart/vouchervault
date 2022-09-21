import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/either.dart' as E;
import 'package:fpdt/option.dart' as O;
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/app/atoms.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

final _log = Logger('barcode_scanner_field/providers/providers.dart');
final cameras = futureAtom((get) => availableCameras());

bool _isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = atom((get) => get(cameras).whenOrElse(
      data: (cameras) => cameras.firstWhereOption(_isRearCamera),
      orElse: () => O.none<CameraDescription>(),
    ))
  ..keepAlive();

final cameraPaused = stateAtom(false);

final _cameraControllerProvider = atom((get) {
  final paused = get(cameraPaused);
  final camera = get(cameraProvider);

  return camera.p(O.filter((_) => !paused)).p(O.map((camera) {
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
  }));
});

final initializedCameraController =
    futureAtom((get) => get(_cameraControllerProvider).p(O.fold(
          () => Future.any<CameraController>([]),
          (c) => c.initialize().then((_) => c),
        )));

final imageProvider = atom((get) => get(initializedCameraController).whenOrElse(
      data: cameraImageStream,
      orElse: () => neverStream<CameraControllerWithImage>(),
    ));

final barcodeResultProvider = atom((get) {
  final ctx = get(mlContextProvider);
  final smartScan = get(appSettings.select((a) => a.smartScan));

  return get(imageProvider)
      .exhaustMap(
        (t) => inputImage(t.second, camera: t.first.description)
            .p(O.map((image) => Stream.fromFuture(
                extractAll(image, embellish: smartScan)(ctx)())))
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
