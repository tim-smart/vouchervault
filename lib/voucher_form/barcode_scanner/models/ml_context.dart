import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

part 'ml_context.freezed.dart';

@freezed
class MlContext with _$MlContext {
  const factory MlContext({
    required TextRecognizer textRecognizer,
    required BarcodeScanner barcodeScanner,
    required EntityExtractor entityExtractor,
  }) = _MlContext;
}
