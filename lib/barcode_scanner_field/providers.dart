import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
// ignore: depend_on_referenced_packages
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final camerasProvider = FutureProvider((ref) => availableCameras());

bool isRearCamera(CameraDescription d) =>
    d.lensDirection == CameraLensDirection.back;

final cameraProvider = Provider(
    (ref) => ref.watch(camerasProvider).when<Option<CameraDescription>>(
          data: (cameras) => cameras.firstWhereOption(isRearCamera),
          error: (err, st) => O.none(),
          loading: () => O.none(),
        ));

final barcodeScannerProvider = Provider((ref) => BarcodeScanner());

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

final flashEnabled = StateProvider((ref) => false);

final flashProvider = Provider.autoDispose((ref) {
  final c = ref.watch(initializedCameraController);
  final enabled = ref.watch(flashEnabled);

  c.whenData((c) => c.setFlashMode(enabled ? FlashMode.torch : FlashMode.off));
});

Option<InputImageData> inputImageData(
  CameraImage image, {
  required CameraDescription camera,
}) {
  final rotation = O.fromNullable(
      InputImageRotationValue.fromRawValue(camera.sensorOrientation));
  final format =
      O.fromNullable(InputImageFormatValue.fromRawValue(image.format.raw));

  return tuple2(rotation, format)
      .p(O.mapTuple2((rotation, format) => InputImageData(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            imageRotation: rotation,
            inputImageFormat: format,
            planeData: image.planes
                .map((p) => InputImagePlaneMetadata(
                      bytesPerRow: p.bytesPerRow,
                      height: p.height,
                      width: p.width,
                    ))
                .toList(),
          )));
}

Option<InputImage> inputImage(
  CameraImage image, {
  required CameraDescription camera,
}) =>
    inputImageData(image, camera: camera).p(O.map((data) {
      final wb = WriteBuffer();
      for (final plane in image.planes) {
        wb.putUint8List(plane.bytes);
      }

      return InputImage.fromBytes(
        bytes: wb.done().buffer.asUint8List(),
        inputImageData: data,
      );
    }));

final _neverStream = StreamController(sync: true).stream;
Stream<T> neverStream<T>() => _neverStream as Stream<T>;

final imageProvider = Provider.autoDispose((ref) {
  ref.watch(initializedCameraController).whenData((c) {
    c.startImageStream((image) => ref.state = O.some(tuple2(c, image)));
  });

  return O.none<Tuple2<CameraController, CameraImage>>();
});

final barcodeProvider = StreamProvider.autoDispose((ref) {
  final scanner = ref.watch(barcodeScannerProvider);
  final c = StreamController<Tuple2<CameraController, CameraImage>>(sync: true);

  ref.listen<Option<Tuple2<CameraController, CameraImage>>>(
      imageProvider, (previous, next) => next.p(O.tap(c.add)));

  return c.stream
      .throttleTime(const Duration(milliseconds: 250))
      .exhaustMap(
        (t) => inputImage(t.second, camera: t.first.description).p(O.fold(
          () => const Stream.empty() as Stream<List<Barcode>>,
          (image) => Stream.fromFuture(scanner.processImage(image)),
        )),
      )
      .expand((b) => b);
});
