import 'package:flutter/foundation.dart';
import 'package:fpdt/fpdt.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

part 'barcode_result.freezed.dart';

@freezed
class BarcodeResult with _$BarcodeResult {
  const factory BarcodeResult({
    required Barcode barcode,
    @Default(kNone) Option<String> merchant,
    @Default(kNone) Option<int> balance,
    @Default(kNone) Option<DateTime> expires,
  }) = _BarcodeResult;
}
