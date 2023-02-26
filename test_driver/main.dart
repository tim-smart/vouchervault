import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/main.dart' as app;
import 'package:vouchervault/vouchers/index.dart';

void main() async {
  WidgetsApp.debugAllowBannerOverride = false;
  enableFlutterDriverExtension();

  app.main(
    vouchers: IList([
      Voucher(
        uuid: Option.of(const Uuid().v4()),
        description: "Walmart",
        code: const Option.of('12345'),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.BLUE,
        balanceMilliunits: const Option.of(77 * 1000),
        expires: DateTime.now().add(const Duration(days: 120)).chain(Option.of),
      ),
      Voucher(
        uuid: const Uuid().v4().chain(Option.of),
        description: "Starbucks",
        code: "12345".chain(Option.of),
        codeType: VoucherCodeType.CODE128,
        color: VoucherColor.GREEN,
        balanceMilliunits: const Option.of(50 * 1000),
      ),
      Voucher(
        uuid: const Uuid().v4().chain(Option.of),
        description: "New World Clubcard",
        code: "12345".chain(Option.of),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.RED,
      ),
      Voucher(
        uuid: const Uuid().v4().chain(Option.of),
        description: "Barkers",
        code: "12345".chain(Option.of),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.GREY,
        balanceMilliunits: const Option.of(100 * 1000),
      ),
    ]),
  );
}
