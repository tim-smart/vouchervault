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
      _$enumDecode(_$AuthenticatedReasonEnumMap, json['reason']),
    );

Map<String, dynamic> _$$AuthenticatedToJson(_$Authenticated instance) =>
    <String, dynamic>{
      'reason': _$AuthenticatedReasonEnumMap[instance.reason],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$AuthenticatedReasonEnumMap = {
  AuthenticatedReason.NOT_AVAILABLE: 'NOT_AVAILABLE',
  AuthenticatedReason.NOT_REQUIRED: 'NOT_REQUIRED',
  AuthenticatedReason.SUCCESS: 'SUCCESS',
};
