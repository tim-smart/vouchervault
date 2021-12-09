import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:offset_iterator_persist/offset_iterator_persist.dart';
import 'package:offset_iterator_riverpod/offset_iterator_riverpod.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/lib/and_then.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

final _log = Logger('auth_bloc.dart');

final localAuthProvider = Provider((ref) => LocalAuthentication());

final authIteratorProvider = Provider((ref) {
  final i = authIterator(ref.watch(storageProvider));
  ref.onDispose(i.close);
  i.add(AuthActions.init(ref));
  return i;
});

final authProvider = Provider((ref) =>
    ref.watch(authIteratorProvider).andThen(stateIteratorValueProvider(ref)));

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

typedef AuthAction = StateIteratorAction<AuthState>;

class AuthActions {
  static AuthAction init(ref) => (value, add) {
        if (value.enabled) {
          add(AuthState.unauthenticated());
          return Future.value();
        }

        return TaskEither.tryCatch(
          () => (ref.read(localAuthProvider) as LocalAuthentication)
              .isDeviceSupported(),
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

  static AuthAction authenticate(ref) => (value, add) => TaskEither.tryCatch(
        () => (ref.read(localAuthProvider) as LocalAuthentication).authenticate(
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

StateIterator<AuthState> authIterator(Storage storage) => StateIterator(
      initialState: AuthState.authenticated(AuthenticatedReason.NOT_AVAILABLE),
      transform: (parent) => parent.persist(
        storage: storage,
        key: 'AuthBloc',
        toJson: (v) => v.toJson(),
        fromJson: (json) => AuthState.fromJson(json as Map<String, dynamic>),
      ),
    );
