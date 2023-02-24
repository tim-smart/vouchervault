import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vouchervault/voucher_form/index.dart';

typedef BarcodeIO<A> = EIO<MlError, A>;

class BarcodeScannerService {
  const BarcodeScannerService({
    required this.textRecognizer,
    required this.barcodeScanner,
    required this.entityExtractor,
  });

  final TextRecognizer textRecognizer;
  final BarcodeScanner barcodeScanner;
  final EntityExtractor entityExtractor;

  BarcodeIO<IList<Barcode>> scan(InputImage image) => EIO
      .tryCatch(
        () => barcodeScanner.processImage(image),
        (err, stackTrace) => MlError.mlkitError(op: 'scan', err: err),
      )
      .map((_) => _.toIList());

  BarcodeIO<RecognizedText> ocr(InputImage image) => EIO.tryCatch(
        () => textRecognizer.processImage(image),
        (error, stackTrace) => MlError.mlkitError(op: 'ocr', err: error),
      );

  BarcodeIO<IList<EntityAnnotation>> extractEntities(
    String text, {
    List<EntityType> filter = const [],
  }) =>
      EIO
          .tryCatch(
            () => entityExtractor.annotateText(text, entityTypesFilter: filter),
            (error, stackTrace) => MlError.mlkitError(
              op: 'extractEntities',
              err: error,
            ),
          )
          .map((_) => _.toIList());

  BarcodeIO<BarcodeResult> extractAll(
    InputImage image, {
    bool embellish = false,
  }) =>
      scan(image)
          .flatMapOptionOrFail(
            (_) => _.firstOption.map((t) => BarcodeResult(barcode: t)),
            (_) => const MlError.barcodeNotFound(),
          )
          .flatMap(
            (_) => embellish
                ? _embellishResult(image: image, result: _)
                : ZIO.succeed(_),
          );

  BarcodeIO<BarcodeResult> _embellishResult({
    required InputImage image,
    required BarcodeResult result,
  }) =>
      ocr(image)
          .flatMap2(
            (_) => extractEntities(_.text, filter: [
              EntityType.money,
              EntityType.dateTime,
            ]),
          )
          .map(
            (_) => result.copyWith(
              merchant: extractMerchant(_.first),
              balance: extractBalance(_.second),
              expires: extractExpires(_.first, _.second),
            ),
          );

  BarcodeIO<BarcodeResult> extractAllFromFile(bool embellish) => pickInputImage
      .mapError(MlError.pickerError)
      .flatMap((_) => extractAll(_, embellish: embellish));
}

// === layers
final barcodeScannerLayer = Layer.scoped([
  _acquireScanner,
  _acquireTextRecognizer,
  _acquireEntityExtractor,
] //
    .collect
    .map(
      (_) => BarcodeScannerService(
        barcodeScanner: _[0] as BarcodeScanner,
        textRecognizer: _[1] as TextRecognizer,
        entityExtractor: _[2] as EntityExtractor,
      ),
    ));

final barcodeScannerAtom = barcodeScannerLayer.atomSyncOnly;

final _acquireScanner = IO(BarcodeScanner.new) //
    .acquireRelease((_) => IO(_.close).asUnit);

final _acquireTextRecognizer = IO(TextRecognizer.new) //
    .acquireRelease((_) => IO(_.close).asUnit);

final _acquireEntityExtractor =
    IO(() => EntityExtractor(language: EntityExtractorLanguage.english)) //
        .acquireRelease((_) => IO(_.close).asUnit);
