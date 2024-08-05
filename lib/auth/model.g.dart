// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnauthenticatedImpl _$$UnauthenticatedImplFromJson(
        Map<String, dynamic> json) =>
    _$UnauthenticatedImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnauthenticatedImplToJson(
        _$UnauthenticatedImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AuthenticatedImpl _$$AuthenticatedImplFromJson(Map<String, dynamic> json) =>
    _$AuthenticatedImpl(
      $enumDecode(_$AuthenticatedReasonEnumMap, json['reason']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AuthenticatedImplToJson(_$AuthenticatedImpl instance) =>
    <String, dynamic>{
      'reason': _$AuthenticatedReasonEnumMap[instance.reason]!,
      'runtimeType': instance.$type,
    };

const _$AuthenticatedReasonEnumMap = {
  AuthenticatedReason.NOT_AVAILABLE: 'NOT_AVAILABLE',
  AuthenticatedReason.NOT_REQUIRED: 'NOT_REQUIRED',
  AuthenticatedReason.SUCCESS: 'SUCCESS',
};
