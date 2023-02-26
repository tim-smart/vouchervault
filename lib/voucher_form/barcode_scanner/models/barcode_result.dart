import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

part 'barcode_result.freezed.dart';

@freezed
class BarcodeResult with _$BarcodeResult {
  const factory BarcodeResult({
    required Barcode barcode,
    @Default(Option.none()) Option<String> merchant,
    @Default(Option.none()) Option<int> balance,
    @Default(Option.none()) Option<DateTime> expires,
  }) = _BarcodeResult;
}
