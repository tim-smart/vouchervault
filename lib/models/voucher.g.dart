// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    uuid: json['uuid'] as String,
    description: json['description'] as String,
    code: json['code'] as String,
    codeType: _$enumDecodeNullable(_$VoucherCodeTypeEnumMap, json['codeType']),
    expires: json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String),
    removeOnceExpired: json['removeOnceExpired'] as bool ?? true,
    balance: (json['balance'] as num)?.toDouble(),
    color: _$enumDecodeNullable(_$VoucherColorEnumMap, json['color']),
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'description': instance.description,
      'code': instance.code,
      'codeType': _$VoucherCodeTypeEnumMap[instance.codeType],
      'expires': instance.expires?.toIso8601String(),
      'removeOnceExpired': instance.removeOnceExpired,
      'balance': instance.balance,
      'color': _$VoucherColorEnumMap[instance.color],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VoucherCodeTypeEnumMap = {
  VoucherCodeType.CODE128: 'CODE128',
  VoucherCodeType.CODE39: 'CODE39',
  VoucherCodeType.EAN13: 'EAN13',
  VoucherCodeType.QR: 'QR',
  VoucherCodeType.TEXT: 'TEXT',
};

const _$VoucherColorEnumMap = {
  VoucherColor.GREY: 'GREY',
  VoucherColor.BLUE: 'BLUE',
  VoucherColor.GREEN: 'GREEN',
  VoucherColor.ORANGE: 'ORANGE',
  VoucherColor.PURPLE: 'PURPLE',
  VoucherColor.RED: 'RED',
  VoucherColor.YELLOW: 'YELLOW',
};
