// ignore_for_file: depend_on_referenced_packages

import 'package:fpdt/fpdt.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:logging/logging.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/auth/model.dart';
import 'package:vouchervault/lib/srte.dart';

final authLogProvider = loggerProvider('auth/ops.dart');

typedef AuthOp<R> = StateReaderTaskEither<AuthState, AuthContext, String, R>;
AuthOp<AuthContext> _ask() => SRTE.ask();
AuthOp<AuthState> _get() => SRTE.get();

class AuthContext {
  const AuthContext({
    required this.log,
    required this.localAuth,
  });

  final Logger log;
  final LocalAuthentication localAuth;
}

final init = _get()
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
    .p(tapLeftC((c) => c.log.info));

final toggle =
    _get().p(SRTE.chainModify((s) => s.enabled ? s.disable() : s.enable()));

final _cancel = _ask().p(SRTE.chainTryCatchK(
  (c) => c.localAuth.stopAuthentication(),
  (err, stackTrace) => 'Could not cancel previous auth requests',
));

final authenticate = _cancel
    .p(SRTE.flatMapReaderTaskEither((_) => TE.tryCatchK(
          (c) => c.localAuth.authenticate(
            localizedReason: 'Please authenticate to view your vouchers',
            authMessages: const [
              AndroidAuthMessages(
                biometricHint: '',
              ),
              IOSAuthMessages(),
            ],
          ),
          (err, _) => 'Error trying to authenticate: $err',
        )))
    .p(SRTE.filter(identity, (_) => 'Authentication failed'))
    .p(SRTE.chainPut(AuthState.success))
    .p(tapLeftC((c) => c.log.info));
