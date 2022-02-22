import 'package:fpdt/fpdt.dart';
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:local_auth/auth_strings.dart';
import 'package:logging/logging.dart';
import 'package:vouchervault/auth/model.dart';
import 'package:vouchervault/auth/providers.dart';
import 'package:vouchervault/lib/riverpod.dart';

final _log = Logger('auth/auth_state.dart');

typedef AuthOp<R> = StateReaderTaskEither<AuthState, RefRead, String, R>;
AuthOp<RefRead> _ask() => SRTE.ask();

final init = _ask().p(SRTE.flatMapS((_) => (s) => (read) {
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
          .p(TE.alt((left) {
        _log.info(left);
        return TE.right(AuthState.notAvailable);
      }));
    }));

final toggle =
    _ask().p(SRTE.chainModify((s) => s.enabled ? s.disable() : s.enable()));

final authenticate = _ask().p(SRTE.flatMapS((_) => (s) => (read) => TE
    .tryCatch(
      () => read(localAuthProvider).authenticate(
        androidAuthStrings: const AndroidAuthMessages(
          signInTitle: 'Voucher Vault',
          biometricHint: '',
        ),
        iOSAuthStrings: const IOSAuthMessages(),
        localizedReason: 'Please authenticate to view your vouchers',
        stickyAuth: true,
      ),
      (err, _) => 'Error trying to authenticate: $err',
    )
    .p(TE.filter(identity, (_) => 'Authentication failed'))
    .p(TE.map((_) => AuthState.success))));
