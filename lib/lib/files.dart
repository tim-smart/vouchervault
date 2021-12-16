import 'dart:io';

import 'package:fpdt/function.dart';
import 'package:fpdt/iterable.dart';
import 'package:fpdt/task_either.dart' as TE;
import 'package:fpdt/tuple.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vouchervault/lib/task_either.dart';

TE.TaskEither<String, File> create(String filename) =>
    tryCatchString(getTemporaryDirectory, prefix: 'Failed to get tmp dir')
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
    tryCatchString(
      () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
      prefix: 'Could not read file',
    ).chain(TE.map((bytes) => tuple2(f, bytes)));

TE.TaskEither<String, Tuple2<PlatformFile, List<int>>> pick(
  List<String> extensions,
) =>
    tryCatchString(
      () => FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensions,
        withReadStream: true,
      ),
      prefix: 'pickFiles failed',
    )
        .chain(TE.chainNullableK(() => 'pickFiles gave no result'))
        .chain(TE.flatMap((r) => r.files.head
            .chain(TE.fromOption(() => 'pickFiles had an empty response'))))
        .chain(TE.flatMap(_readPlatformFileStream));
