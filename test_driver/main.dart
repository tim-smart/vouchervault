import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart' as O;
import 'package:uuid/uuid.dart';
import 'package:vouchervault/main.dart' as app;
import 'package:vouchervault/models/voucher.dart';

void main() async {
  WidgetsApp.debugAllowBannerOverride = false;
  enableFlutterDriverExtension();

  app.main(
    vouchers: IList([
      Voucher(
        uuid: O.some(const Uuid().v4()),
        description: "Walmart",
        code: O.some('12345'),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.BLUE,
        balanceMilliunits: O.some(77 * 1000),
        expires: DateTime.now().add(const Duration(days: 120)).chain(O.some),
      ),
      Voucher(
        uuid: const Uuid().v4().chain(O.some),
        description: "Starbucks",
        code: "12345".chain(O.some),
        codeType: VoucherCodeType.CODE128,
        color: VoucherColor.GREEN,
        balanceMilliunits: O.some(50 * 1000),
      ),
      Voucher(
        uuid: const Uuid().v4().chain(O.some),
        description: "New World Clubcard",
        code: "12345".chain(O.some),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.RED,
      ),
      Voucher(
        uuid: const Uuid().v4().chain(O.some),
        description: "Barkers",
        code: "12345".chain(O.some),
        codeType: VoucherCodeType.QR,
        color: VoucherColor.GREY,
        balanceMilliunits: O.some(100 * 1000),
      ),
    ]),
  );
}
