import 'package:fpdart/fpdart.dart';
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

final authProvider = BlocStreamProvider<AuthBloc, AuthState>(
    (ref) => AuthBloc()..add(AuthActions.init(ref.read)));

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

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  bool get available =>
      this != Authenticated(AuthenticatedReason.NOT_AVAILABLE);

  bool get enabled => when(
        unauthenticated: () => true,
        authenticated: (reason) => reason == AuthenticatedReason.SUCCESS,
      );

  AuthState enable() => available
      ? AuthState.unauthenticated()
      : AuthState.authenticated(AuthenticatedReason.NOT_AVAILABLE);

  AuthState disable() => available
      ? AuthState.authenticated(AuthenticatedReason.NOT_REQUIRED)
      : AuthState.authenticated(AuthenticatedReason.NOT_AVAILABLE);
}

typedef AuthAction = BlocStreamAction<AuthState>;

class AuthActions {
  static AuthAction init(RefRead read) => (value, add) {
        if (value.enabled) {
          add(AuthState.unauthenticated());
          return Future.value();
        }

        return TaskEither.tryCatch(
          () => read(localAuthProvider).isDeviceSupported(),
          (error, stackTrace) => 'Could not check if auth is available',
        )
            .filterOrElse(
              (available) => available,
              (_) => 'Auth not available',
            )
            .match(
              (message) {
                _log.info(message);
                return AuthenticatedReason.NOT_AVAILABLE;
              },
              (_) => AuthenticatedReason.NOT_REQUIRED,
            )
            .map((reason) => AuthState.authenticated(reason))
            .map(add)
            .run();
      };

  static AuthAction toggle() =>
      (value, add) => add(value.enabled ? value.disable() : value.enable());

  static AuthAction authenticate(RefRead read) => (value, add) =>
      TaskEither.tryCatch(
        () => read(localAuthProvider).authenticate(
          androidAuthStrings: AndroidAuthMessages(
            signInTitle: 'Voucher Vault',
            biometricHint: '',
          ),
          iOSAuthStrings: IOSAuthMessages(),
          localizedReason: 'Please authenticate to view your vouchers',
          stickyAuth: true,
        ),
        (err, _) => 'Error trying to authenticate: $err',
      )
          .filterOrElse((success) => success, (_) => 'Authentication failed')
          .map((_) => add(AuthState.authenticated(AuthenticatedReason.SUCCESS)))
          .getOrElse(_log.warning)
          .run();
}

class AuthBloc extends PersistedBlocStream<AuthState> {
  AuthBloc()
      : super(AuthState.authenticated(AuthenticatedReason.NOT_AVAILABLE));

  @override
  toJson(AuthState value) => value.toJson();

  @override
  AuthState fromJson(json) => AuthState.fromJson(json);
}
