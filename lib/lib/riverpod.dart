import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_persistence/riverpod_persistence.dart';
import 'package:vouchervault/app/providers.dart';

typedef RefRead = T Function<T>(ProviderBase<T> provider);

Provider<StateRTEMachine<S, C, L>> persistedSMProvider<S, C, L>({
  required StateRTEMachine<S, C, L> Function(Ref ref, S? initial) create,
  required String key,
  required FromJson<S> fromJson,
  required ToJson<S> toJson,
}) =>
    persistProvider<Provider<StateRTEMachine<S, C, L>>, S>(
      (read, write) => Provider((ref) {
        final sm = stateMachineProvider<StateRTEMachine<S, C, L>>(
          ref,
          create(ref, read(ref)),
        );
        ref.onDispose(sm.stream.listen(write(ref)).cancel);
        return sm;
      }),
      buildStorage: (ref) => SharedPreferencesStorage(
        // Use same key prefix as persisted_bloc_stream
        keyPrefix: 'pbs_',
        key: key,
        toJson: toJson,
        fromJson: fromJson,
        instance: ref.watch(sharedPreferencesProvider),
      ),
    );

Option<A> asyncValueToOption<A>(AsyncValue<A> value) =>
    value.maybeWhen(data: O.some, orElse: O.none);
