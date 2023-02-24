// ignore_for_file: constant_identifier_names

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vouchervault/lib/lib.dart';

part 'voucher.freezed.dart';
part 'voucher.g.dart';

enum VoucherCodeType {
  AZTEC,
  CODE128,
  CODE39,
  EAN13,
  PDF417,
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
  VoucherColor.GREEN: Colors.green[600]!,
  VoucherColor.RED: Colors.red[700]!,
  VoucherColor.YELLOW: Colors.yellow[700]!,
  VoucherColor.ORANGE: Colors.orange[800]!,
  VoucherColor.PURPLE: Colors.purple[500]!,
};
final color = (VoucherColor color) =>
    _colors.lookup(color).getOrElse(() => Colors.grey[700]!);
String colorToJson(VoucherColor c) => _$VoucherColorEnumMap[c]!;

// Voucher code type functions
String codeTypeToJson(VoucherCodeType c) => _$VoucherCodeTypeEnumMap[c]!;

final Map<VoucherCodeType, String> _codeTypeLabelMap = {
  VoucherCodeType.AZTEC: 'Aztec',
  VoucherCodeType.CODE128: 'Code128',
  VoucherCodeType.CODE39: 'Code39',
  VoucherCodeType.EAN13: 'EAN-13',
  VoucherCodeType.PDF417: 'PDF417',
  VoucherCodeType.QR: 'QR Code',
  VoucherCodeType.TEXT: 'Text',
};
String codeTypeLabel(VoucherCodeType type) => _codeTypeLabelMap[type]!;

final codeTypeFromJson = (String? json) => Option.fromNullable(json)
    .flatMap(
      (t) => Option.tryCatch(() => $enumDecode(_$VoucherCodeTypeEnumMap, t)),
    )
    .getOrElse(() => VoucherCodeType.CODE128);

@freezed
class Voucher with _$Voucher {
  Voucher._();

  factory Voucher({
    @Default(None()) Option<String> uuid,
    @Default('') String description,
    @Default(None()) Option<String> code,
    @Default(VoucherCodeType.CODE128) VoucherCodeType codeType,
    @Default(None()) Option<DateTime> expires,
    @Default(true) bool removeOnceExpired,
    @Default(None()) Option<double> balance,
    @Default(None()) Option<int> balanceMilliunits,
    @Default('') String notes,
    @Default(VoucherColor.GREY) VoucherColor color,
  }) = _Voucher;

  factory Voucher.fromJson(dynamic json) =>
      _$VoucherFromJson(Map<String, dynamic>.from(json));

  late final Option<DateTime> normalizedExpires =
      expires.map((d) => d.endOfDay);

  late final Option<DateTime> removeAt =
      normalizedExpires.filter((_) => removeOnceExpired);

  late final Option<int> balanceOption =
      balanceMilliunits.alt(() => balance.map(millisFromDouble));

  late final Option<double> balanceDoubleOption =
      balanceOption.map(millisToDouble);

  late final Option<String> notesOption = optionOfString(notes);

  late final bool hasDetails =
      normalizedExpires.isSome() || balanceOption.isSome();
  late final bool hasDetailsOrNotes = hasDetails || notesOption.isSome();

  static Voucher fromFormValue(dynamic json) =>
      Voucher.fromJson(<String, dynamic>{
        ...json,
        'balanceMilliunits':
            millisFromString(json['balanceMilliunits']).toNullable(),
      });

  dynamic toFormValue() => <String, dynamic>{
        ...toJson(),
        'balanceMilliunits': balanceOption.map(millisToString).toNullable(),
        'codeType': _$VoucherCodeTypeEnumMap[codeType],
        'expires': expires.toNullable(),
        'color': _$VoucherColorEnumMap[this.color],
      };
}
