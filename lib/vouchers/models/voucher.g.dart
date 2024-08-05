// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherImpl _$$VoucherImplFromJson(Map<String, dynamic> json) =>
    _$VoucherImpl(
      uuid: json['uuid'] == null
          ? const Option.none()
          : Option<String>.fromJson(json['uuid'], (value) => value as String),
      description: json['description'] as String? ?? '',
      code: json['code'] == null
          ? const Option.none()
          : Option<String>.fromJson(json['code'], (value) => value as String),
      codeType:
          $enumDecodeNullable(_$VoucherCodeTypeEnumMap, json['codeType']) ??
              VoucherCodeType.CODE128,
      expires: json['expires'] == null
          ? const Option.none()
          : Option<DateTime>.fromJson(
              json['expires'], (value) => DateTime.parse(value as String)),
      removeOnceExpired: json['removeOnceExpired'] as bool? ?? true,
      balance: json['balance'] == null
          ? const Option.none()
          : Option<double>.fromJson(
              json['balance'], (value) => (value as num).toDouble()),
      balanceMilliunits: json['balanceMilliunits'] == null
          ? const Option.none()
          : Option<int>.fromJson(
              json['balanceMilliunits'], (value) => (value as num).toInt()),
      notes: json['notes'] as String? ?? '',
      color: $enumDecodeNullable(_$VoucherColorEnumMap, json['color']) ??
          VoucherColor.GREY,
    );

Map<String, dynamic> _$$VoucherImplToJson(_$VoucherImpl instance) =>
    <String, dynamic>{
      'uuid': instance.uuid.toJson(
        (value) => value,
      ),
      'description': instance.description,
      'code': instance.code.toJson(
        (value) => value,
      ),
      'codeType': _$VoucherCodeTypeEnumMap[instance.codeType]!,
      'expires': instance.expires.toJson(
        (value) => value.toIso8601String(),
      ),
      'removeOnceExpired': instance.removeOnceExpired,
      'balance': instance.balance.toJson(
        (value) => value,
      ),
      'balanceMilliunits': instance.balanceMilliunits.toJson(
        (value) => value,
      ),
      'notes': instance.notes,
      'color': _$VoucherColorEnumMap[instance.color]!,
    };

const _$VoucherCodeTypeEnumMap = {
  VoucherCodeType.AZTEC: 'AZTEC',
  VoucherCodeType.CODE128: 'CODE128',
  VoucherCodeType.CODE39: 'CODE39',
  VoucherCodeType.EAN13: 'EAN13',
  VoucherCodeType.PDF417: 'PDF417',
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
