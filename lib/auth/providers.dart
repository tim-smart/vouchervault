import 'package:fpdt/fpdt.dart';
import 'package:fpdt/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_persistence/riverpod_persistence.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/auth/ops.dart';
import 'package:vouchervault/auth/model.dart';
import 'package:vouchervault/lib/riverpod.dart';

final localAuthProvider = Provider((ref) => LocalAuthentication());

typedef AuthStateMachine = StateRTEMachine<AuthState, RefRead, String>;

final authSMProvider = persistProvider<Provider<AuthStateMachine>, AuthState>(
  (read, write) => Provider((ref) {
    final sm =
        stateMachineProvider(ref)(StateRTEMachine<AuthState, RefRead, String>(
      read(ref) ?? AuthState.notAvailable,
      ref.read,
    ));

    ref.onDispose(sm.stream.listen(write(ref)).cancel);

    // Init
    sm.evaluate(init);

    return sm;
  }),
  buildStorage: (ref) => SharedPreferencesStorage(
    // Use same key as previous AuthBloc
    keyPrefix: 'pbs_',
    key: 'AuthBloc',
    toJson: (s) => s.toJson(),
    fromJson: (json) => AuthState.fromJson(json),
    instance: ref.watch(sharedPreferencesProvider),
  ),
);

final authProvider = Provider(
  (ref) => stateMachineStateProvider(ref)(ref.watch(authSMProvider)),
);

final authEnabledProvider = Provider((ref) => ref.watch(authProvider).enabled);
final authAvailableProvider =
    Provider((ref) => ref.watch(authProvider).available);
