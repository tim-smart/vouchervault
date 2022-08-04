import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

final barcodeScannerProvider = Provider.autoDispose((ref) {
  final scanner = BarcodeScanner();
  ref.onDispose(scanner.close);
  return scanner;
});

final textRecognizerProvider = Provider((ref) {
  final r = TextRecognizer();
  ref.onDispose(r.close);
  return r;
});

final entityRecognizerProvider = Provider((ref) {
  final ee = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );
  ref.onDispose(ee.close);
  return ee;
});

final mlContextProvider = Provider.autoDispose((ref) => MlContext(
      textRecognizer: ref.watch(textRecognizerProvider),
      barcodeScanner: ref.watch(barcodeScannerProvider),
      entityExtractor: ref.watch(entityRecognizerProvider),
    ));
