import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' hide Barcode;
import 'package:vouchervault/models/voucher.dart';

final Map<VoucherCodeType, Barcode> _codeTypeMap = {
  VoucherCodeType.CODE128: Barcode.code128(),
  VoucherCodeType.CODE39: Barcode.code39(),
  VoucherCodeType.EAN13: Barcode.ean13(),
  VoucherCodeType.QR: Barcode.qrCode(),
};
Option<Barcode> fromCodeType(VoucherCodeType type) =>
    optionOf(_codeTypeMap[type]);

Option<Barcode> fromCodeTypeJson(String s) => fromCodeType(codeTypeFromJson(s));

final Map<BarcodeFormat, VoucherCodeType> _barcodeFormatMap = {
  BarcodeFormat.code128: VoucherCodeType.CODE128,
  BarcodeFormat.code39: VoucherCodeType.CODE39,
  BarcodeFormat.ean13: VoucherCodeType.EAN13,
  BarcodeFormat.qrcode: VoucherCodeType.QR,
};
VoucherCodeType codeTypeFromFormat(BarcodeFormat f) =>
    optionOf(_barcodeFormatMap[f]).getOrElse(() => VoucherCodeType.CODE128);

String? codeTypeValueFromFormat(BarcodeFormat f) =>
    codeTypeToJson(codeTypeFromFormat(f));
