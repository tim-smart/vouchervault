import 'dart:async';

import 'package:fpdt/function.dart';
import 'package:fpdt/task_either.dart';

TaskEither<String, R> tryCatchString<R>(
  Lazy<FutureOr<R>> task, {
  String prefix = 'tryCatchString',
}) =>
    tryCatch(task, (err, stack) => '$prefix: $err');
