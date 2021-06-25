import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/main.dart' as app;
import 'package:vouchervault/models/voucher.dart';

void main() async {
  WidgetsApp.debugAllowBannerOverride = false;
  enableFlutterDriverExtension();

  app.main(vouchers: [
    Voucher(
      uuid: Uuid().v4(),
      description: "Walmart",
      code: "12345",
      codeType: VoucherCodeType.QR,
      color: VoucherColor.BLUE,
      balance: 77,
      expires: DateTime.now().add(Duration(days: 120)),
    ),
    Voucher(
      uuid: Uuid().v4(),
      description: "Starbucks",
      code: "12345",
      codeType: VoucherCodeType.CODE128,
      color: VoucherColor.GREEN,
      balance: 50,
    ),
    Voucher(
      uuid: Uuid().v4(),
      description: "New World Clubcard",
      code: "12345",
      codeType: VoucherCodeType.QR,
      color: VoucherColor.RED,
    ),
    Voucher(
      uuid: Uuid().v4(),
      description: "Barkers",
      code: "12345",
      codeType: VoucherCodeType.QR,
      color: VoucherColor.GREY,
      balance: 100,
    ),
  ]);
}
