import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/lib/lib.dart';

typedef CameraControllerWithImage = Tuple2<CameraController, CameraImage>;

Stream<CameraControllerWithImage> cameraImageStream(
  CameraController c, {
  Duration throttleTime = const Duration(milliseconds: 250),
  int skipFrames = 3,
}) {
  late StreamController<CameraControllerWithImage> sc;

  Future<void> onStart() =>
      c.startImageStream((image) => sc.add(tuple2(c, image)));

  sc = StreamController(
    onListen: onStart,
    onCancel: c.stopImageStream,
    sync: true,
  );

  return sc.stream
      .throttleTime(throttleTime)
      .skip(skipFrames)
      .asBroadcastStream();
}

Option<InputImageData> inputImageData(
  CameraImage image, {
  required CameraDescription camera,
}) =>
    Option.fromNullable(
      InputImageRotationValue.fromRawValue(camera.sensorOrientation),
    ).flatMap(
      (rotation) => Option.fromNullable(
        InputImageFormatValue.fromRawValue(image.format.raw),
      ).map(
        (format) => InputImageData(
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
        ),
      ),
    );

Option<InputImage> inputImage(
  CameraImage image, {
  required CameraDescription camera,
}) =>
    inputImageData(image, camera: camera).map((data) {
      final wb = WriteBuffer();

      for (final plane in image.planes) {
        wb.putUint8List(plane.bytes);
      }

      return InputImage.fromBytes(
        bytes: wb.done().buffer.asUint8List(),
        inputImageData: data,
      );
    });

final _neverController = StreamController.broadcast(sync: true);
Stream<T> neverStream<T>() => _neverController.stream.cast();

final pickInputImage = pickImage.flatMapOptionOrFail(
  (i) => Option.fromNullable(i.path).map(InputImage.fromFilePath),
  (_) => 'pickInputImage: pickImage returned empty path',
);
