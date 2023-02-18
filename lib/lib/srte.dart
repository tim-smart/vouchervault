import 'package:fpdt/fpdt.dart';
import 'package:fpdt/task_either.dart' as TE;
import 'package:fpdt/state_reader_task_either.dart' as SRTE;

StateReaderTaskEither<S, C, L, R> Function(
  StateReaderTaskEither<S, C, L, R>,
) tapLeftC<S, C, L, R>(
  void Function(L) Function(C) f,
) =>
    (fa) =>
        fa.p(SRTE.alt((l) => SRTE.fromReaderTaskEither(ReaderTaskEither((r) {
              f(r)(l);
              return TE.left(l);
            }))));
