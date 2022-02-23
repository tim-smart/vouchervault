import 'package:fpdt/fpdt.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:local_auth/auth_strings.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/auth/model.dart';
import 'package:vouchervault/auth/providers.dart';
import 'package:vouchervault/lib/riverpod.dart';
import 'package:vouchervault/lib/srte.dart';

final _log = loggerProvider('auth/ops.dart');

typedef AuthOp<R> = StateReaderTaskEither<AuthState, RefRead, String, R>;
AuthOp<RefRead> _ask() => SRTE.ask();
AuthOp<AuthState> _get() => SRTE.get();

final init = _get().p(SRTE.flatMapReaderTaskEither((s) => (read) {
      if (s.enabled) {
        return TE.right(const AuthState.unauthenticated());
      }

      return TE
          .tryCatch(
            () => read(localAuthProvider).isDeviceSupported(),
            (error, stackTrace) => 'Could not check if auth is available',
          )
          .p(TE.filter(identity, (_) => 'Auth not available'))
          .p(TE.map((_) => AuthState.notRequired))
          .p(TE.tapLeft(read(_log).info))
          .p(TE.orElse(TE.right(AuthState.notAvailable)));
    }));

final toggle =
    _get().p(SRTE.chainModify((s) => s.enabled ? s.disable() : s.enable()));

final authenticate = _ask()
    .p(SRTE.flatMapTaskEither(TE.tryCatchK(
      (read) => read(localAuthProvider).authenticate(
        androidAuthStrings: const AndroidAuthMessages(
          signInTitle: 'Voucher Vault',
          biometricHint: '',
        ),
        iOSAuthStrings: const IOSAuthMessages(),
        localizedReason: 'Please authenticate to view your vouchers',
        stickyAuth: true,
      ),
      (err, _) => 'Error trying to authenticate: $err',
    )))
    .p(SRTE.filter(identity, (_) => 'Authentication failed'))
    .p(SRTE.chainPut(AuthState.success))
    .p(tapLeftC((read) => read(_log).info));
