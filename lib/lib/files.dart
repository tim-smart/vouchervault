import 'dart:io';

import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

EIO<String, File> createFile(String filename) => EIO
    .tryCatch(getTemporaryDirectory, (err, s) => 'Failed to get tmp dir: $err')
    .map((d) => File('${d.path}/$filename'));

EIO<String, File> writeFile(String filename, List<int> bytes) =>
    createFile(filename).flatMapThrowable(
      (f) => f.writeAsBytes(bytes),
      (err, stackTrace) => 'Failed to write bytes: $err',
    );

EIO<String, File> writeStringToFile(
  String filename,
  String content,
) =>
    createFile(filename).flatMapThrowable(
      (f) => f.writeAsString(content),
      (err, stackTrace) => 'Failed to write string: $err',
    );

EIO<String, Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    EIO
        .tryCatch(
          () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
          (err, s) => 'Could not read file: $err',
        )
        .map((bytes) => tuple2(f, bytes));

EIO<String, Tuple2<PlatformFile, List<int>>> pickFile({
  FileType type = FileType.any,
  List<String>? extensions,
}) =>
    EIO
        .tryCatch(
          () async {
            await FilePicker.platform.clearTemporaryFiles();
            return FilePicker.platform.pickFiles(
              type: type,
              allowedExtensions: extensions,
              withReadStream: true,
            );
          },
          (err, s) => 'pickFiles failed: $err',
        )
        .flatMapNullableOrFail(identity, (_) => 'pickFiles gave no result')
        .flatMapOptionOrFail(
          (r) => r.files.head,
          (_) => 'pickFiles had an empty response',
        )
        .flatMap(_readPlatformFileStream);

final pickImage = EIO
    .tryCatch(
      () => FilePicker.platform.pickFiles(type: FileType.image),
      (err, s) => 'pickFiles failed: $err',
    )
    .flatMapNullableOrFail(identity, (_) => 'file picker cancelled')
    .flatMapOptionOrFail(
      (r) => r.files.head,
      (_) => 'pickFiles had an empty response',
    );
