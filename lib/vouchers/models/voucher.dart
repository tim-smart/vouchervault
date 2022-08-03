// ignore_for_file: constant_identifier_names

import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vouchervault/lib/milliunits.dart' as millis;
import 'package:vouchervault/lib/option.dart';

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
final color = _colors.lookup.c(O.getOrElse(() => Colors.grey[700]!));
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

final codeTypeFromJson = O
    .fromNullableWith<String>()
    .c(O.chainTryCatchK((s) => $enumDecode(_$VoucherCodeTypeEnumMap, s)))
    .c(O.getOrElse(() => VoucherCodeType.CODE128));

@freezed
class Voucher with _$Voucher {
  Voucher._();

  factory Voucher({
    @Default(O.kNone) Option<String> uuid,
    @Default('') String description,
    @Default(O.kNone) Option<String> code,
    @Default(VoucherCodeType.CODE128) VoucherCodeType codeType,
    @Default(O.kNone) Option<DateTime> expires,
    @Default(true) bool removeOnceExpired,
    @Default(O.kNone) Option<double> balance,
    @Default(O.kNone) Option<int> balanceMilliunits,
    @Default('') String notes,
    @Default(VoucherColor.GREY) VoucherColor color,
  }) = _Voucher;

  factory Voucher.fromJson(dynamic json) =>
      _$VoucherFromJson(Map<String, dynamic>.from(json));

  late final Option<DateTime> normalizedExpires =
      expires.p(O.map((d) => d.endOfDay));

  late final Option<DateTime> removeAt =
      normalizedExpires.p(O.filter((_) => removeOnceExpired));

  late final Option<int> balanceOption =
      balanceMilliunits.p(O.alt(() => balance.p(O.map(millis.fromDouble))));

  late final Option<double> balanceDoubleOption =
      balanceOption.p(O.map(millis.toDouble));

  late final Option<String> notesOption = optionOfString(notes);

  late final bool hasDetails =
      O.isSome(normalizedExpires) || O.isSome(balanceOption);
  late final bool hasDetailsOrNotes = hasDetails || O.isSome(notesOption);

  static Voucher fromFormValue(dynamic json) =>
      Voucher.fromJson(<String, dynamic>{
        ...json,
        'balanceMilliunits':
            millis.fromString(json['balanceMilliunits']).p(O.toNullable),
      });

  dynamic toFormValue() => <String, dynamic>{
        ...toJson(),
        'balanceMilliunits':
            balanceOption.p(O.flatMap(millis.toString)).p(O.toNullable),
        'codeType': _$VoucherCodeTypeEnumMap[codeType],
        'expires': O.toNullable(expires),
        'color': _$VoucherColorEnumMap[this.color],
      };
}
