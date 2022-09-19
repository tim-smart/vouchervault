import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fpdt/fpdt.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/lib/nucleus.dart';

final localAuthProvider = atom((get) => LocalAuthentication());

final authState = smAtom<AuthState, AuthContext, String>(
  (get, initial) => StateRTEMachine(
    initial?.init() ?? AuthState.notAvailable,
    AuthContext(localAuth: get(localAuthProvider)),
  )..run(init),
  key: 'pbs_AuthBloc',
  fromJson: (json) => AuthState.fromJson(json),
  toJson: (s) => s.toJson(),
)..keepAlive();

final authEnabledAtom = authState.select((s) => s.enabled);
final authAvailableAtom = authState.select((s) => s.available);
