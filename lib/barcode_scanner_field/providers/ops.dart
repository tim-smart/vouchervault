import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:vouchervault/barcode_scanner_field/lib/extract_merchant.dart';
import 'package:vouchervault/barcode_scanner_field/providers/barcode_result.dart';
import 'package:vouchervault/lib/files.dart';

part 'ops.freezed.dart';

@freezed
class MlContext with _$MlContext {
  const factory MlContext({
    required TextRecognizer textRecognizer,
    required BarcodeScanner barcodeScanner,
    required EntityExtractor entityExtractor,
  }) = _MlContext;
}

typedef BarcodeOp<A> = ReaderTaskEither<MlContext, String, A>;

BarcodeOp<List<Barcode>> scan(InputImage image) => TE.tryCatchK(
      (c) => c.barcodeScanner.processImage(image),
      (err, stackTrace) => 'scan err: $err',
    );

BarcodeOp<RecognizedText> ocr(InputImage image) => TE.tryCatchK(
      (c) => c.textRecognizer.processImage(image),
      (err, stackTrace) => 'ocr err: $err',
    );

BarcodeOp<List<EntityAnnotation>> extractEntities(
  String text, {
  List<EntityType> filter = const [],
}) =>
    TE.tryCatchK(
      (c) => c.entityExtractor.annotateText(text, entityTypesFilter: filter),
      (err, stackTrace) => 'extractEntities err: $err',
    );

BarcodeOp<BarcodeResult> extractAll(InputImage image) => scan(image)
    .p(RTE.flatMap(
      (b) => b.firstOption
          .p(O.map((b) => BarcodeResult(barcode: b)))
          .p(RTE.fromOption((p0) => 'extractAll: no barcode found')),
    ))
    .p(RTE.flatMap((result) => _decorateResult(image: image, result: result)));

final extractAllFromFile = pickImage()
    .p(TE.flatMap((i) => O
        .fromNullable(i.path)
        .p(O.map(InputImage.fromFilePath))
        .p(TE.fromOption(
            () => 'extractAllFromFile: pickImage returned empty path'))))
    // ignore: unnecessary_cast
    .p((te) => RTE.fromTaskEither(te) as BarcodeOp<InputImage>)
    .p(RTE.flatMap(extractAll));

BarcodeOp<BarcodeResult> _decorateResult({
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
              balance: _extractBalance(t.second),
              expires: _extractExpires(t.second),
            )));

int _moneyToMillis(MoneyEntity e) =>
    (e.integerPart * 1000) + (e.fractionPart * 10);

Option<int> _extractBalance(List<EntityAnnotation> e) => e
    .expand((e) => e.entities)
    .where((e) => e.type == EntityType.money)
    .cast<MoneyEntity>()
    .map(_moneyToMillis)
    .toIList()
    .sort()
    .lastOption;

DateTime _toDateTime(DateTimeEntity e) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp * 1000);

  return e.dateTimeGranularity == DateTimeGranularity.month
      ? dateTime.endOfMonth
      : dateTime;
}

List<DateTime> _extractDateTimes(List<EntityAnnotation> e) {
  final dates = e
      .expand((e) => e.entities)
      .where((e) => e.type == EntityType.dateTime)
      .cast<DateTimeEntity>()
      .where((e) =>
          e.dateTimeGranularity == DateTimeGranularity.day ||
          e.dateTimeGranularity == DateTimeGranularity.month)
      .map(_toDateTime)
      .toList();

  dates.sort();

  return dates;
}

Option<DateTime> _extractExpires(List<EntityAnnotation> e) =>
    _extractDateTimes(e).where((dt) => dt.isFuture).lastOption;
