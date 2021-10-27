// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Unauthenticated _$$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    _$Unauthenticated();

Map<String, dynamic> _$$UnauthenticatedToJson(_$Unauthenticated instance) =>
    <String, dynamic>{};

_$Authenticated _$$AuthenticatedFromJson(Map<String, dynamic> json) =>
    _$Authenticated(
      $enumDecode(_$AuthenticatedReasonEnumMap, json['reason']),
    );

Map<String, dynamic> _$$AuthenticatedToJson(_$Authenticated instance) =>
    <String, dynamic>{
      'reason': _$AuthenticatedReasonEnumMap[instance.reason],
    };

const _$AuthenticatedReasonEnumMap = {
  AuthenticatedReason.NOT_AVAILABLE: 'NOT_AVAILABLE',
  AuthenticatedReason.NOT_REQUIRED: 'NOT_REQUIRED',
  AuthenticatedReason.SUCCESS: 'SUCCESS',
};
