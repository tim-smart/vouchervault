import 'package:fpdt/fpdt.dart';
import 'package:fpdt/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vouchervault/auth/model.dart';
import 'package:vouchervault/auth/ops.dart';
import 'package:vouchervault/lib/riverpod.dart';

final localAuthProvider = Provider((ref) => LocalAuthentication());

final authSMProvider = persistedSMProvider<AuthState, RefRead, String>(
  create: (ref, initial) => StateRTEMachine(
    initial ?? AuthState.notAvailable,
    ref.read,
  )..run(init),
  key: 'AuthBloc',
  fromJson: (json) => AuthState.fromJson(json),
  toJson: (s) => s.toJson(),
);

final authProvider = Provider(
  (ref) => stateMachineStateProvider(ref, ref.watch(authSMProvider)),
);

final authEnabledProvider = Provider((ref) => ref.watch(authProvider).enabled);
final authAvailableProvider =
    Provider((ref) => ref.watch(authProvider).available);
