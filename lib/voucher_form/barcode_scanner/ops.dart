import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

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
