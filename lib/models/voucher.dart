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
  TEXT,
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

// Color functions
final _colors = <VoucherColor, Color>{
  VoucherColor.BLUE: Colors.blue,
  VoucherColor.GREEN: Colors.green[600],
  VoucherColor.RED: Colors.red[700],
  VoucherColor.YELLOW: Colors.yellow[700],
  VoucherColor.ORANGE: Colors.orange[800],
  VoucherColor.PURPLE: Colors.purple[500],
};
Color color(VoucherColor c) =>
    optionOf(_colors[c]).getOrElse(() => Colors.grey[700]);
String colorToJson(VoucherColor c) => _$VoucherColorEnumMap[c];

// Voucher code type functions
String codeTypeToJson(VoucherCodeType c) => _$VoucherCodeTypeEnumMap[c];

final Map<VoucherCodeType, String> _codeTypeLabelMap = {
  VoucherCodeType.CODE128: 'Code128',
  VoucherCodeType.EAN13: 'EAN-13',
  VoucherCodeType.QR: 'QR Code',
  VoucherCodeType.TEXT: 'Text',
};
String codeTypeLabel(VoucherCodeType type) => _codeTypeLabelMap[type];

VoucherCodeType codeTypeFromJson(String s) =>
    optionOf(_$enumDecodeNullable(_$VoucherCodeTypeEnumMap, s))
        .getOrElse(() => VoucherCodeType.CODE128);

@JsonSerializable()
class Voucher extends Equatable {
  Voucher({
    String uuid,
    this.description = '',
    this.code,
    this.codeType = VoucherCodeType.CODE128,
    this.expires,
    this.removeOnceExpired = true,
    this.balance,
    this.color = VoucherColor.GREY,
  }) : this.uuid = uuid ?? uuidgen.v4();

  @JsonKey(nullable: false)
  final String uuid;

  final String description;
  final String code;
  final VoucherCodeType codeType;
  Option<String> get codeOption => optionOf(code);
  final DateTime expires;
  Option<DateTime> get expiresOption => optionOf(expires);
  @JsonKey(defaultValue: true)
  final bool removeOnceExpired;
  final double balance;
  Option<double> get balanceOption => optionOf(balance);
  final VoucherColor color;

  bool get hasDetails => expiresOption.isSome() || balanceOption.isSome();

  @override
  List<Object> get props => [
        description,
        code,
        codeType,
        expires,
        removeOnceExpired,
        balance,
        color,
      ];

  dynamic toJson() => _$VoucherToJson(this);
  static Voucher fromJson(dynamic json) => _$VoucherFromJson(json);

  static Voucher fromFormValue(Map<String, dynamic> json) => fromJson(json);
  dynamic toFormValue() => <String, dynamic>{
        ...toJson(),
        'codeType': _$VoucherCodeTypeEnumMap[codeType],
        'expires': expires,
        'color': _$VoucherColorEnumMap[color],
      };

  Voucher copyWith({
    String uuid,
    String description,
    String code,
    VoucherCodeType codeType,
    Option<DateTime> expires,
    bool removeOnceExpired,
    Option<double> balance,
    VoucherColor color,
  }) =>
      Voucher(
        uuid: uuid ?? this.uuid,
        description: description ?? this.description,
        code: code ?? this.code,
        codeType: codeType ?? this.codeType,
        expires: (expires ?? expiresOption) | null,
        removeOnceExpired: removeOnceExpired ?? this.removeOnceExpired,
        balance: (balance ?? balanceOption) | null,
        color: color ?? this.color,
      );
}
