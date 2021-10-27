// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Voucher _$$_VoucherFromJson(Map<String, dynamic> json) => _$_Voucher(
      uuid: json['uuid'] as String?,
      description: json['description'] as String? ?? '',
      code: json['code'] as String?,
      codeType:
          $enumDecodeNullable(_$VoucherCodeTypeEnumMap, json['codeType']) ??
              VoucherCodeType.CODE128,
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
      removeOnceExpired: json['removeOnceExpired'] as bool? ?? true,
      balance: (json['balance'] as num?)?.toDouble(),
      balanceMilliunits: json['balanceMilliunits'] as int?,
      color: $enumDecodeNullable(_$VoucherColorEnumMap, json['color']) ??
          VoucherColor.GREY,
    );

Map<String, dynamic> _$$_VoucherToJson(_$_Voucher instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'description': instance.description,
      'code': instance.code,
      'codeType': _$VoucherCodeTypeEnumMap[instance.codeType],
      'expires': instance.expires?.toIso8601String(),
      'removeOnceExpired': instance.removeOnceExpired,
      'balance': instance.balance,
      'balanceMilliunits': instance.balanceMilliunits,
      'color': _$VoucherColorEnumMap[instance.color],
    };

const _$VoucherCodeTypeEnumMap = {
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
