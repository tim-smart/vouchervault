import 'package:fpdt/fpdt.dart';
import 'package:fpdt_flutter/fpdt_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/lib/lib.dart';

final localAuthProvider = Provider((ref) => LocalAuthentication());

final authSMProvider = persistedSMProvider<AuthState, AuthContext, String>(
  create: (ref, initial) => StateRTEMachine(
    initial?.init() ?? AuthState.notAvailable,
    AuthContext(
      log: ref.watch(authLogProvider),
      localAuth: ref.watch(localAuthProvider),
    ),
  )..run(init),
  key: 'AuthBloc',
  fromJson: (json) => AuthState.fromJson(json),
  toJson: (s) => s.toJson(),
);

final authProvider = Provider(
  (ref) => stateMachineStateProvider(ref, ref.watch(authSMProvider)),
);

final authEnabledProvider = authProvider.select((s) => s.enabled);
final authAvailableProvider = authProvider.select((s) => s.available);
