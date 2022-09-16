import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fpdt/fpdt.dart';
import 'package:vouchervault/app/atoms.dart';

AtomWithParent<S, Atom<StateRTEMachine<S, C, L>>> smAtom<S, C, L>(
  StateRTEMachine<S, C, L> Function(
    AtomContext<StateRTEMachine<S, C, L>> get,
    S? initialValue,
  )
      create, {
  required String key,
  required S Function(dynamic) fromJson,
  required dynamic Function(S) toJson,
}) =>
    atomWithParent(
      atomWithStorage<StateRTEMachine<S, C, L>, S>(
        (get, read, write) {
          final sm = create(get, read());
          sm.stream.listen(write);
          get.onDispose(sm.close);
          return sm;
        },
        key: key,
        storage: nucleusStorage,
        fromJson: fromJson,
        toJson: toJson,
      ),
      (get, parent) {
        final sm = get(parent);
        get.onDispose(sm.stream.listen(get.setSelf).cancel);
        return sm.state;
      },
    );
