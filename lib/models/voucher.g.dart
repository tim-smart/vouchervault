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
    expires: json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String),
    balance: (json['balance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'description': instance.description,
      'code': instance.code,
      'expires': instance.expires?.toIso8601String(),
      'balance': instance.balance,
    };
