import 'dart:io';

import 'package:fpdt/fpdt.dart';
import 'package:fpdt/task_either.dart' as TE;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

TaskEither<String, File> create(String filename) => TE
    .tryCatch(getTemporaryDirectory, (err, s) => 'Failed to get tmp dir: $err')
    .p(TE.map((d) => File('${d.path}/$filename')));

TaskEither<String, File> write(String filename, List<int> bytes) =>
    create(filename).p(TE.chainTryCatchK(
      (f) => f.writeAsBytes(bytes),
      (err, stackTrace) => 'Failed to write bytes: $err',
    ));

TaskEither<String, File> writeString(String filename, String data) =>
    create(filename).p(TE.chainTryCatchK(
      (f) => f.writeAsString(data),
      (err, stackTrace) => 'Failed to write string: $err',
    ));

TaskEither<String, Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    TE
        .tryCatch(
          () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
          (err, s) => 'Could not read file: $err',
        )
        .p(TE.map((bytes) => tuple2(f, bytes)));

TaskEither<String, Tuple2<PlatformFile, List<int>>> pick(
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
        .p(TE.chainNullableK(() => 'pickFiles gave no result'))
        .p(TE.flatMap((r) => r.files.head
            .p(TE.fromOption(() => 'pickFiles had an empty response'))))
        .p(TE.flatMap(_readPlatformFileStream));
