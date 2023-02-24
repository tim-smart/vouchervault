import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

part 'barcode_result.freezed.dart';

@freezed
class BarcodeResult with _$BarcodeResult {
  const factory BarcodeResult({
    required Barcode barcode,
    @Default(None()) Option<String> merchant,
    @Default(None()) Option<int> balance,
    @Default(None()) Option<DateTime> expires,
  }) = _BarcodeResult;
}
