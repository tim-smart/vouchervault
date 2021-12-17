import 'dart:io';

import 'package:fpdt/function.dart';
import 'package:fpdt/iterable.dart';
import 'package:fpdt/task_either.dart' as TE;
import 'package:fpdt/tuple.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

TE.TaskEither<String, File> create(String filename) => TE
    .tryCatch(getTemporaryDirectory, (err, s) => 'Failed to get tmp dir: $err')
    .chain(TE.map((d) => File('${d.path}/$filename')));

TE.TaskEither<String, File> write(String filename, List<int> bytes) =>
    create(filename).chain(TE.chainTryCatchK(
      (f) => f.writeAsBytes(bytes),
      (err, stackTrace) => 'Failed to write bytes: $err',
    ));

TE.TaskEither<String, File> writeString(String filename, String data) =>
    create(filename).chain(TE.chainTryCatchK(
      (f) => f.writeAsString(data),
      (err, stackTrace) => 'Failed to write string: $err',
    ));

TE.TaskEither<String, Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    TE
        .tryCatch(
          () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
          (err, s) => 'Could not read file: $err',
        )
        .chain(TE.map((bytes) => tuple2(f, bytes)));

TE.TaskEither<String, Tuple2<PlatformFile, List<int>>> pick(
  List<String> extensions,
) =>
    TE
        .tryCatch(
          () => FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: extensions,
            withReadStream: true,
          ),
          (err, s) => 'pickFiles failed: $err',
        )
        .chain(TE.chainNullableK(() => 'pickFiles gave no result'))
        .chain(TE.flatMap((r) => r.files.head
            .chain(TE.fromOption(() => 'pickFiles had an empty response'))))
        .chain(TE.flatMap(_readPlatformFileStream));
