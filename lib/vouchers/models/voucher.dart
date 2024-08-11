// ignore_for_file: constant_identifier_names

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vouchervault/lib/lib.dart';

part 'voucher.freezed.dart';
part 'voucher.g.dart';

enum VoucherCodeType {
  AZTEC(label: 'Aztec', square: true),
  CODE128(label: 'Code128'),
  CODE39(label: 'Code39'),
  EAN13(label: 'EAN-13'),
  PDF417(label: 'PDF417'),
  QR(label: 'QR Code', square: true),
  TEXT(label: 'Text');

  final String label;
  final bool square;

  const VoucherCodeType({
    required this.label,
    this.square = false,
  });
}

enum VoucherColor {
  GREY(color: Color(0xFF616161)),
  BLUE(color: Colors.blue),
  GREEN(color: Color(0xFF43A047)),
  ORANGE(color: Color(0xFFEF6C00)),
  PURPLE(color: Colors.purple),
  RED(color: Color(0xFFD32F2F)),
  YELLOW(color: Color(0xFFFBC02D));

  final Color color;

  const VoucherColor({
    required this.color,
  });

  ThemeData theme(ThemeData theme) {
    return theme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        brightness: theme.brightness,
        seedColor: color,
        primary: color,
        onPrimary: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      ),
    );
  }
}

String colorToJson(VoucherColor c) => _$VoucherColorEnumMap[c]!;

// Voucher code type functions
String codeTypeToJson(VoucherCodeType c) => _$VoucherCodeTypeEnumMap[c]!;

final codeTypeFromJson = (String? json) => Option.fromNullable(json)
    .flatMap(
      (t) => Option.tryCatch(() => $enumDecode(_$VoucherCodeTypeEnumMap, t)),
    )
    .getOrElse(() => VoucherCodeType.CODE128);

@freezed
class Voucher with _$Voucher {
  Voucher._();

  factory Voucher({
    @Default(Option.none()) Option<String> uuid,
    @Default('') String description,
    @Default(Option.none()) Option<String> code,
    @Default(VoucherCodeType.CODE128) VoucherCodeType codeType,
    @Default(Option.none()) Option<DateTime> expires,
    @Default(true) bool removeOnceExpired,
    @Default(Option.none()) Option<double> balance,
    @Default(Option.none()) Option<int> balanceMilliunits,
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
        'color': _$VoucherColorEnumMap[color],
      };
}
