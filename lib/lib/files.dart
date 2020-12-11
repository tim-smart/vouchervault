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

Future<Option<PlatformFile>> pick(List<String> extensions) =>
    FilePicker.platform
        .pickFiles(
          type: FileType.custom,
          allowedExtensions: extensions,
          withData: true,
        )
        .then(optionOf)
        .then((r) => r.bind((r) => optionOf(r.files.first)));
