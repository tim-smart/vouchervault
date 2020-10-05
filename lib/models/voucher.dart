import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'voucher.g.dart';

final uuidgen = Uuid();

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

@JsonSerializable()
class Voucher extends Equatable {
  Voucher({
    String uuid,
    this.description = '',
    this.code,
    this.expires,
    this.balance,
    this.color = VoucherColor.GREY,
  }) : this.uuid = uuid ?? uuidgen.v4();

  final String uuid;
  final String description;
  final String code;
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
        code: json['code'] as String,
        expires: json['expires'],
        balance: (json['balance'] as num)?.toDouble(),
        color: _$enumDecodeNullable(_$VoucherColorEnumMap, json['color']),
      );

  dynamic toFormValue() => <String, dynamic>{
        'uuid': uuid,
        'description': description,
        'code': code,
        'expires': expires,
        'balance': balance,
        'color': _$VoucherColorEnumMap[color],
      };

  Voucher copyWith({
    String uuid,
    String description,
    String code,
    Option<DateTime> expires,
    Option<double> balance,
    VoucherColor color,
  }) {
    return Voucher(
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      code: code ?? this.code,
      expires: (expires ?? expiresOption) | null,
      balance: (balance ?? balanceOption) | null,
      color: color ?? this.color,
    );
  }
}
