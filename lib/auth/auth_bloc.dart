// ignore_for_file: constant_identifier_names

import 'package:fpdt/fpdt.dart';
import 'package:fpdt/task.dart' as T;
import 'package:fpdt/task_either.dart' as TE;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:riverpod_bloc_stream/riverpod_bloc_stream.dart';
import 'package:vouchervault/lib/riverpod.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

final _log = Logger('auth_bloc.dart');

final localAuthProvider = Provider((ref) => LocalAuthentication());

final authProvider = BlocStreamProvider(
  (ref) => AuthBloc()..add(AuthActions.init(ref.read)),
);

final authEnabledProvider = Provider((ref) => ref.watch(authProvider).enabled);
final authAvailableProvider =
    Provider((ref) => ref.watch(authProvider).available);

enum AuthenticatedReason {
  NOT_AVAILABLE,
  NOT_REQUIRED,
  SUCCESS,
}

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated(AuthenticatedReason reason) =
      Authenticated;

  static const notAvailable =
      AuthState.authenticated(AuthenticatedReason.NOT_AVAILABLE);
  static const notRequired =
      AuthState.authenticated(AuthenticatedReason.NOT_REQUIRED);
  static const success = AuthState.authenticated(AuthenticatedReason.SUCCESS);

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  bool get available =>
      this != const Authenticated(AuthenticatedReason.NOT_AVAILABLE);

  bool get enabled => when(
        unauthenticated: () => true,
        authenticated: (reason) => reason == AuthenticatedReason.SUCCESS,
      );

  AuthState enable() =>
      available ? const AuthState.unauthenticated() : notAvailable;

  AuthState disable() => available ? notRequired : notAvailable;
}

typedef AuthAction = BlocStreamAction<AuthState>;

class AuthActions {
  static AuthAction init(RefRead read) => (value, add) {
        if (value.enabled) {
          add(const AuthState.unauthenticated());
          return null;
        }

        return TE
            .tryCatch(
              () => read(localAuthProvider).isDeviceSupported(),
              (error, stackTrace) => 'Could not check if auth is available',
            )
            .p(TE.filter(
              (available) => available,
              (_) => 'Auth not available',
            ))
            .p(TE.fold(
              (message) {
                _log.info(message);
                return AuthState.notAvailable;
              },
              (_) => AuthState.notRequired,
            ))
            .p(T.map(add))();
      };

  static AuthAction toggle() =>
      (value, add) => add(value.enabled ? value.disable() : value.enable());

  static AuthAction authenticate(RefRead read) => (value, add) => TE
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
      .p(TE.map((_) => add(AuthState.success)))
      .p(TE.toFutureVoid(_log.warning));
}

class AuthBloc extends PersistedBlocStream<AuthState> {
  AuthBloc() : super(AuthState.notAvailable);

  @override
  toJson(AuthState value) => value.toJson();

  @override
  AuthState fromJson(json) => AuthState.fromJson(json);
}
