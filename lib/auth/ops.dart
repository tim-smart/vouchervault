// ignore_for_file: depend_on_referenced_packages

import 'package:fpdt/fpdt.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:logging/logging.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/lib/lib.dart';

final _log = Logger('auth/ops.dart');

typedef AuthOp<R> = StateReaderTaskEither<AuthState, AuthContext, String, R>;
final AuthOp<AuthContext> _ask = SRTE.ask();
final AuthOp<AuthState> _get = SRTE.get();

class AuthContext {
  const AuthContext({required this.localAuth});
  final LocalAuthentication localAuth;
}

final init = _get
    .p(SRTE.filter(
      (s) => !s.enabled,
      (_) => 'Auth already enabled',
    ))
    .p(SRTE.flatMapReaderTaskEither((s) => TE.tryCatchK(
          (c) => c.localAuth.isDeviceSupported(),
          (error, stackTrace) => 'Could not check if auth is available',
        )))
    .p(SRTE.flatMap((available) =>
        SRTE.put(available ? AuthState.notRequired : AuthState.notAvailable)))
    .p(tapLeftC((c) => _log.info));

final toggle =
    _get.p(SRTE.chainModify((s) => s.enabled ? s.disable() : s.enable()));

final _cancel = _ask.p(SRTE.chainTryCatchK(
  (c) => c.localAuth.stopAuthentication(),
  (err, stackTrace) => 'Could not cancel previous auth requests',
));

final authenticate = _cancel
    .p(SRTE.flatMapReaderTaskEither((_) => TE.tryCatchK(
          (c) => c.localAuth.authenticate(
            localizedReason: ' ',
            authMessages: const [
              AndroidAuthMessages(
                signInTitle: 'Unlock your vouchers',
                biometricHint: '',
              ),
              IOSAuthMessages(),
            ],
          ),
          (err, _) => 'Error trying to authenticate: $err',
        )))
    .p(SRTE.filter(identity, (_) => 'Authentication failed'))
    .p(SRTE.chainPut(AuthState.success))
    .p(tapLeftC((c) => _log.info));
