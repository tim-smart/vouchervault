import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> create(String filename) =>
    getTemporaryDirectory().then((dir) => File('${dir.path}/$filename'));

Future<File> write(String filename, List<int> bytes) =>
    create(filename).then((file) => file.writeAsBytes(bytes));

Future<File> writeString(String filename, String data) =>
    create(filename).then((file) => file.writeAsString(data));

Future<Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    f.readStream
        .reduce((bytes, chunk) => bytes + chunk)
        .then((bytes) => tuple2(f, bytes));

Future<Option<Tuple2<PlatformFile, List<int>>>> pick(
    List<String> extensions) async {
  try {
    return await FilePicker.platform
        .pickFiles(
          type: FileType.custom,
          allowedExtensions: extensions,
          withReadStream: true,
        )
        .then((r) => optionOf(r))
        .then((r) => r.bind((r) => optionOf(r.files.first)))
        .then((f) => f.traverseFuture(_readPlatformFileStream));
  } catch (_) {}

  return none();
}
