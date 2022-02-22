import 'package:fpdt/fpdt.dart';
import 'package:fpdt/task_either.dart' as TE;

StateReaderTaskEither<S, C, L, R> Function(
  StateReaderTaskEither<S, C, L, R>,
) tapLeftC<S, C, L, R>(
  void Function(L) Function(C) f,
) =>
    (fa) => (s) => (c) => fa(s)(c).p(TE.tapLeft(f(c)));
