import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' as O;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher.freezed.dart';
part 'voucher.g.dart';

enum VoucherCodeType {
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
Color color(VoucherColor c) =>
    O.fromNullable(_colors[c]).chain(O.getOrElse(() => Colors.grey[700]!));
String colorToJson(VoucherColor c) => _$VoucherColorEnumMap[c]!;

// Voucher code type functions
String codeTypeToJson(VoucherCodeType c) => _$VoucherCodeTypeEnumMap[c]!;

final Map<VoucherCodeType, String> _codeTypeLabelMap = {
  VoucherCodeType.CODE128: 'Code128',
  VoucherCodeType.CODE39: 'Code39',
  VoucherCodeType.EAN13: 'EAN-13',
  VoucherCodeType.PDF417: 'PDF417',
  VoucherCodeType.QR: 'QR Code',
  VoucherCodeType.TEXT: 'Text',
};
String codeTypeLabel(VoucherCodeType type) => _codeTypeLabelMap[type]!;

VoucherCodeType codeTypeFromJson(String? s) => O
    .fromNullable(s)
    .chain(O.map((s) => $enumDecode(_$VoucherCodeTypeEnumMap, s)))
    .chain(O.getOrElse(() => VoucherCodeType.CODE128));

@freezed
class Voucher with _$Voucher {
  Voucher._();

  factory Voucher({
    String? uuid,
    @Default('') String description,
    String? code,
    @Default(VoucherCodeType.CODE128) VoucherCodeType codeType,
    DateTime? expires,
    @Default(true) bool removeOnceExpired,
    double? balance,
    int? balanceMilliunits,
    @Default(VoucherColor.GREY) VoucherColor color,
  }) = _Voucher;

  factory Voucher.fromJson(dynamic json) =>
      _$VoucherFromJson(Map<String, dynamic>.from(json));

  late final O.Option<String> codeOption = O.fromNullable(code);

  late final O.Option<DateTime> expiresOption = O.fromNullable(expires);

  late final O.Option<int> balanceOption = O
      .fromNullable(balanceMilliunits)
      .chain(O.alt(() =>
          O.fromNullable(balance).chain(O.map((b) => (b * 1000).round()))));

  late final O.Option<double> balanceDoubleOption =
      balanceOption.chain(O.map((b) => b / 1000.0));

  late final bool hasDetails =
      O.isSome(expiresOption) || O.isSome(balanceOption);

  static Voucher fromFormValue(dynamic json) => Voucher.fromJson(json);

  dynamic toFormValue() => <String, dynamic>{
        ...toJson(),
        'balanceMilliunits': O.toNullable(balanceOption),
        'codeType': _$VoucherCodeTypeEnumMap[codeType],
        'expires': expires,
        'color': _$VoucherColorEnumMap[this.color],
      };
}
