// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

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

  bool get available => this != notAvailable;

  bool get enabled => when(
        unauthenticated: () => true,
        authenticated: (reason) => reason == AuthenticatedReason.SUCCESS,
      );

  AuthState enable() =>
      available ? const AuthState.unauthenticated() : notAvailable;

  AuthState disable() => available ? notRequired : notAvailable;

  AuthState init() => enabled ? const AuthState.unauthenticated() : this;
}
