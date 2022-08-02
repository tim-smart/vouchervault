import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_either.dart' as TE;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vouchervault/lib/files.dart';

typedef CameraControllerWithImage = Tuple2<CameraController, CameraImage>;

Stream<CameraControllerWithImage> cameraImageStream(
  CameraController c, {
  Duration throttleTime = const Duration(milliseconds: 150),
}) {
  late StreamController<CameraControllerWithImage> sc;

  void onStart() {
    c.startImageStream((image) => sc.add(tuple2(c, image)));
  }

  sc = StreamController(
    onListen: onStart,
    sync: true,
  );

  return sc.stream.throttleTime(throttleTime);
}

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

final _neverController = StreamController.broadcast(sync: true);
Stream<T> neverStream<T>() => _neverController.stream.cast();

final pickInputImage = pickImage().p(TE.flatMap((i) => O
    .fromNullable(i.path)
    .p(O.map(InputImage.fromFilePath))
    .p(TE.fromOption(() => 'pickInputImage: pickImage returned empty path'))));
