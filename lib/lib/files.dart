import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> create(String filename) =>
    getTemporaryDirectory().then((dir) => File('${dir.path}/$filename'));

Future<File> write(String filename, List<int> bytes) =>
    create(filename).then((file) => file.writeAsBytes(bytes));

Future<File> writeString(String filename, String data) =>
    create(filename).then((file) => file.writeAsString(data));

TaskEither<String, Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    TaskEither.tryCatch(
      () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
      (error, _stackTrace) => 'Could not read file: $error',
    ).map((bytes) => tuple2(f, bytes));

TaskEither<String, Tuple2<PlatformFile, List<int>>> pick(
  List<String> extensions,
) =>
    TaskEither.tryCatch(
      () => FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensions,
        withReadStream: true,
      ),
      (error, _) => 'pickFiles failed: $error',
    )
        .flatMap((r) => TaskEither.fromOption(
              optionOf(r),
              () => 'pickFiles gave no result',
            ))
        .flatMap((r) => TaskEither.fromOption(
              r.files.firstOption,
              () => 'pickFiles had an empty response',
            ))
        .flatMap(_readPlatformFileStream);
