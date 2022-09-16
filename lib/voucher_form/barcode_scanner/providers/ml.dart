import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

final barcodeScannerProvider = atom((get) {
  final scanner = BarcodeScanner();
  get.onDispose(scanner.close);
  return scanner;
});

final textRecognizerProvider = atom((get) {
  final r = TextRecognizer();
  get.onDispose(r.close);
  return r;
});

final entityRecognizerProvider = atom((get) {
  final ee = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );
  get.onDispose(ee.close);
  return ee;
});

final mlContextProvider = atom((get) => MlContext(
      textRecognizer: get(textRecognizerProvider),
      barcodeScanner: get(barcodeScannerProvider),
      entityExtractor: get(entityRecognizerProvider),
    ));
