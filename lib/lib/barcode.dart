import 'package:barcode_widget/barcode_widget.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:qr_code_scanner/qr_code_scanner.dart' hide Barcode;
import 'package:vouchervault/models/voucher.dart';

final Map<VoucherCodeType, Barcode> _codeTypeMap = {
  VoucherCodeType.CODE128: Barcode.code128(),
  VoucherCodeType.CODE39: Barcode.code39(),
  VoucherCodeType.EAN13: Barcode.ean13(),
  VoucherCodeType.PDF417: Barcode.pdf417(),
  VoucherCodeType.QR: Barcode.qrCode(),
};
final fromCodeType = _codeTypeMap.lookup;
final fromCodeTypeJson = codeTypeFromJson.c(fromCodeType);

final Map<BarcodeFormat, VoucherCodeType> _barcodeFormatMap = {
  BarcodeFormat.code128: VoucherCodeType.CODE128,
  BarcodeFormat.code39: VoucherCodeType.CODE39,
  BarcodeFormat.ean13: VoucherCodeType.EAN13,
  BarcodeFormat.pdf417: VoucherCodeType.PDF417,
  BarcodeFormat.qrcode: VoucherCodeType.QR,
};
final codeTypeFromFormat =
    _barcodeFormatMap.lookup.c(O.getOrElse(() => VoucherCodeType.CODE128));

final codeTypeValueFromFormat = codeTypeFromFormat.c(codeTypeToJson);
