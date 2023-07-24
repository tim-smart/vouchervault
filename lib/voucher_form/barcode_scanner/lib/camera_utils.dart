import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/lib/lib.dart';

typedef CameraControllerWithImage = (CameraController, CameraImage);

Stream<CameraControllerWithImage> cameraImageStream(
  CameraController c, {
  Duration throttleTime = const Duration(milliseconds: 250),
  int skipFrames = 3,
}) {
  late StreamController<CameraControllerWithImage> sc;

  Future<void> onStart() => c.startImageStream((image) => sc.add((c, image)));

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

Option<InputImage> inputImage(
  CameraImage image, {
  required CameraDescription camera,
}) =>
    Option.Do(($) {
      final rotation = $(Option.fromNullable(
        InputImageRotationValue.fromRawValue(camera.sensorOrientation),
      ));
      final format = $(Option.fromNullable(
        InputImageFormatValue.fromRawValue(image.format.raw),
      ));
      final plane = $(image.planes.head);
      return InputImage.fromBytes(
        bytes: plane.bytes,
        metadata: InputImageMetadata(
          format: format,
          rotation: rotation,
          size: Size(image.width.toDouble(), image.height.toDouble()),
          bytesPerRow: plane.bytesPerRow,
        ),
      );
    });

final _neverController = StreamController.broadcast(sync: true);
Stream<T> neverStream<T>() => _neverController.stream.cast();

final pickInputImage = pickImage.flatMapOptionOrFail(
  (i) => Option.fromNullable(i.path).map(InputImage.fromFilePath),
  (_) => 'pickInputImage: pickImage returned empty path',
);
