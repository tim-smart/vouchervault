import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vouchervault/barcode_scanner_field/lib/camera_utils.dart';
import 'package:vouchervault/barcode_scanner_field/lib/extraction.dart';
import 'package:vouchervault/barcode_scanner_field/providers/barcode_result.dart';

part 'ops.freezed.dart';

@freezed
class MlContext with _$MlContext {
  const factory MlContext({
    required TextRecognizer textRecognizer,
    required BarcodeScanner barcodeScanner,
    required EntityExtractor entityExtractor,
  }) = _MlContext;
}

@freezed
class MlError with _$MlError {
  const MlError._();

  const factory MlError.barcodeNotFound() = _MlErrorBarcodeNotFound;
  const factory MlError.pickerError(String message) = _MlErrorPicker;
  const factory MlError.mlkitError({
    required String op,
    required dynamic err,
  }) = _MlErrorMlKit;

  String get friendlyMessage => when(
        barcodeNotFound: () => 'Could not find a barcode',
        pickerError: (msg) => 'Could not load image: $msg',
        mlkitError: (op, err) => 'Could not process image in method: $op',
      );
}

typedef BarcodeOp<A> = ReaderTaskEither<MlContext, MlError, A>;

BarcodeOp<List<Barcode>> scan(InputImage image) => TE.tryCatchK(
      (c) => c.barcodeScanner.processImage(image),
      (err, stackTrace) => MlError.mlkitError(op: 'scan', err: err),
    );

BarcodeOp<RecognizedText> ocr(InputImage image) => TE.tryCatchK(
      (c) => c.textRecognizer.processImage(image),
      (err, stackTrace) => MlError.mlkitError(op: 'ocr', err: err),
    );

BarcodeOp<List<EntityAnnotation>> extractEntities(
  String text, {
  List<EntityType> filter = const [],
}) =>
    TE.tryCatchK(
      (c) => c.entityExtractor.annotateText(text, entityTypesFilter: filter),
      (err, stackTrace) => MlError.mlkitError(op: 'extractEntities', err: err),
    );

BarcodeOp<BarcodeResult> extractAll(
  InputImage image, {
  bool embellish = false,
}) =>
    scan(image)
        .p(RTE.flatMap(
            (b) => b.firstOption.p(O.map((b) => BarcodeResult(barcode: b))).p(
                  RTE.fromOption((p0) => const MlError.barcodeNotFound()),
                )))
        .p(embellish
            ? RTE.flatMap(
                (result) => _embellishResult(image: image, result: result))
            : identity);

BarcodeOp<BarcodeResult> extractAllFromFile(bool embellish) => pickInputImage
    .p(TE.mapLeft((e) => MlError.pickerError(e)))
    .p(RTE.fromTaskEither)
    .p(RTE.flatMap((i) => extractAll(i, embellish: embellish)));

BarcodeOp<BarcodeResult> _embellishResult({
  required InputImage image,
  required BarcodeResult result,
}) =>
    ocr(image)
        .p(RTE.flatMapTuple2((rt) => extractEntities(
              rt.text,
              filter: [EntityType.money, EntityType.dateTime],
            )))
        .p(RTE.map((t) => result.copyWith(
              merchant: extractMerchant(t.first),
              balance: extractBalance(t.second),
              expires: extractExpires(t.second),
            )));
