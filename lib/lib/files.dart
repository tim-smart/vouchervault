import 'dart:io';

import 'package:fpdt/function.dart';
import 'package:fpdt/iterable.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task_either.dart' as TE;
import 'package:fpdt/tuple.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> create(String filename) =>
    getTemporaryDirectory().then((dir) => File('${dir.path}/$filename'));

Future<File> write(String filename, List<int> bytes) =>
    create(filename).then((file) => file.writeAsBytes(bytes));

Future<File> writeString(String filename, String data) =>
    create(filename).then((file) => file.writeAsString(data));

TE.TaskEither<String, Tuple2<PlatformFile, List<int>>> _readPlatformFileStream(
  PlatformFile f,
) =>
    TE
        .tryCatch(
          () => f.readStream!.reduce((bytes, chunk) => bytes + chunk),
          (error, _stackTrace) => 'Could not read file: $error',
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
          (error, _) => 'pickFiles failed: $error',
        )
        .chain(TE.flatMap((f) => O
            .fromNullable(f)
            .chain(TE.fromOption(() => 'pickFiles gave no result'))))
        .chain(TE.flatMap((r) => r.files.head
            .chain(TE.fromOption(() => 'pickFiles had an empty response'))))
        .chain(TE.flatMap(_readPlatformFileStream));
