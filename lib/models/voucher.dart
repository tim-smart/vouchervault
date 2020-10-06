import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'voucher.g.dart';

final uuidgen = Uuid();

enum VoucherCodeType {
  CODE128,
  EAN13,
  QR,
}

enum VoucherColor {
  GREY,
  BLUE,
  GREEN,
  ORANGE,
  PURPLE,
  RED,
  YELLOW,
}

Color voucherColor(VoucherColor c) {
  switch (c) {
    case VoucherColor.BLUE:
      return Colors.blue;
    case VoucherColor.GREEN:
      return Colors.green[600];
    case VoucherColor.GREY:
      return Colors.grey[700];
    case VoucherColor.RED:
      return Colors.red[700];
    case VoucherColor.YELLOW:
      return Colors.yellow[700];
    case VoucherColor.ORANGE:
      return Colors.orange[800];
    case VoucherColor.PURPLE:
      return Colors.purple[500];
  }

  return Colors.grey[700];
}

String voucherColorValue(VoucherColor c) => _$VoucherColorEnumMap[c];

String voucherCodeTypeValue(VoucherCodeType c) => _$VoucherCodeTypeEnumMap[c];

final Map<VoucherCodeType, Barcode> _codeTypeMap = {
  VoucherCodeType.CODE128: Barcode.code128(),
  VoucherCodeType.EAN13: Barcode.ean13(),
  VoucherCodeType.QR: Barcode.qrCode(),
};
Barcode voucherCodeType(VoucherCodeType type) =>
    _codeTypeMap[type ?? VoucherCodeType.CODE128];

final Map<VoucherCodeType, String> _codeTypeLabelMap = {
  VoucherCodeType.CODE128: 'Code128',
  VoucherCodeType.EAN13: 'EAN-13',
  VoucherCodeType.QR: 'QR Code',
};
String voucherCodeTypeLabel(VoucherCodeType type) => _codeTypeLabelMap[type];

VoucherCodeType voucherCodeTypeFromValue(String s) =>
    optionOf(_$enumDecodeNullable(_$VoucherCodeTypeEnumMap, s))
        .getOrElse(() => VoucherCodeType.CODE128);

Barcode barcodeFromVoucherCodeValue(String s) =>
    voucherCodeType(voucherCodeTypeFromValue(s));

final Map<BarcodeFormat, VoucherCodeType> _barcodeFormatMap = {
  BarcodeFormat.ean13: VoucherCodeType.EAN13,
  BarcodeFormat.qr: VoucherCodeType.QR,
};
VoucherCodeType voucherCodeTypeFromBarcodeFormat(BarcodeFormat f) =>
    optionOf(_barcodeFormatMap[f]).getOrElse(() => VoucherCodeType.CODE128);

String voucherCodeTypeValueFromBarcodeFormat(BarcodeFormat f) =>
    voucherCodeTypeValue(voucherCodeTypeFromBarcodeFormat(f));

@JsonSerializable()
class Voucher extends Equatable {
  Voucher({
    String uuid,
    this.description = '',
    this.code,
    this.codeType = VoucherCodeType.CODE128,
    this.expires,
    this.balance,
    this.color = VoucherColor.GREY,
  }) : this.uuid = uuid ?? uuidgen.v4();

  final String uuid;
  final String description;
  final String code;
  final VoucherCodeType codeType;
  Option<String> get codeOption => optionOf(code);
  final DateTime expires;
  Option<DateTime> get expiresOption => optionOf(expires);
  final double balance;
  Option<double> get balanceOption => optionOf(balance);
  final VoucherColor color;

  @override
  List<Object> get props {
    return [
      uuid,
      description,
      code,
      codeType,
      expires,
      balance,
      color,
    ];
  }

  dynamic toJson() => _$VoucherToJson(this);
  static Voucher fromJson(dynamic json) => _$VoucherFromJson(json);

  static Voucher fromFormValue(Map<String, dynamic> json) => Voucher(
        uuid: json['uuid'] as String,
        description: json['description'] as String,
        code: optionOf(json['code'] as String)
            .bind((s) => s.isEmpty ? none() : some(s))
            .getOrElse(() => null),
        codeType:
            _$enumDecodeNullable(_$VoucherCodeTypeEnumMap, json['codeType']),
        expires: json['expires'],
        balance: (json['balance'] as num)?.toDouble(),
        color: _$enumDecodeNullable(_$VoucherColorEnumMap, json['color']),
      );

  dynamic toFormValue() => <String, dynamic>{
        'uuid': uuid,
        'description': description,
        'code': code,
        'codeType': _$VoucherCodeTypeEnumMap[codeType],
        'expires': expires,
        'balance': balance,
        'color': _$VoucherColorEnumMap[color],
      };

  Voucher copyWith({
    String uuid,
    String description,
    String code,
    VoucherCodeType codeType,
    Option<DateTime> expires,
    Option<double> balance,
    VoucherColor color,
  }) =>
      Voucher(
        uuid: uuid ?? this.uuid,
        description: description ?? this.description,
        code: code ?? this.code,
        codeType: codeType ?? this.codeType,
        expires: (expires ?? expiresOption) | null,
        balance: (balance ?? balanceOption) | null,
        color: color ?? this.color,
      );
}
