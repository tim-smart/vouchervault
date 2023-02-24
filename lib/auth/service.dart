// ignore_for_file: depend_on_referenced_packages
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:vouchervault/auth/index.dart';

class AuthService {
  AuthService({
    required this.ref,
    required this.localAuth,
  });

  final Ref<AuthState> ref;
  final LocalAuthentication localAuth;

  IO<Unit> get toggle =>
      ref.update((_) => _.enabled ? _.disable() : _.enable());

  EIO<String, Unit> get _cancel => EIO
      .tryCatch(
        () => localAuth.stopAuthentication(),
        (err, stackTrace) => 'Could not cancel previous auth requests',
      )
      .asUnit;

  IO<Unit> get authenticate => _cancel
      .zipRight(EIO.tryCatch(
        () => localAuth.authenticate(
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
      ))
      .filterOrFail(identity, (_) => 'Authentication failed')
      .zipRight(ref.set(AuthState.success))
      .ignoreLogged;
}

// === layer

final authLayer = Layer.scoped(ZIO.Do(($, env) async {
  final ref = await $(StorageRef.makeScope<AuthState>(
    AuthState.notAvailable,
    key: 'pbs_AuthBloc',
    fromJson: (_) => AuthState.fromJson(_),
    toJson: (_) => _.toJson(),
  ).orDie);

  final localAuth = LocalAuthentication();

  if (ref.unsafeGet().enabled) {
    return AuthService(
      ref: ref,
      localAuth: localAuth,
    );
  }

  final available = await $(
    EIO
        .tryCatch(
          () => localAuth.isDeviceSupported(),
          (error, stackTrace) => 'Could not check if auth is available',
        )
        .logOrElse((_) => false)
        .lift(),
  );

  await $(ref.set(available ? AuthState.notRequired : AuthState.notAvailable));

  return AuthService(
    ref: ref,
    localAuth: localAuth,
  );
}));

// ==== atoms

final authState = zioRefAtomSync(authLayer.accessWith((_) => _.ref));
final authEnabledAtom = authState.select((s) => s.enabled);
final authAvailableAtom = authState.select((s) => s.available);
