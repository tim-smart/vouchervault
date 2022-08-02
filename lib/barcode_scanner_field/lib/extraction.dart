import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:recase/recase.dart';

Option<String> extractMerchant(RecognizedText rt) {
  final lines = eligibleMerchantLines(rt).where(_hasNoNoise);
  return findMerchantWithSuffix(lines)
      .p(O.alt(() => lines.firstOption))
      .p(O.map((s) => s.titleCase));
}

bool _isLargeBlock(TextBlock b) =>
    b.lines.length >= 5 || b.lines.any((l) => l.elements.length >= 7);

bool _isEnglishBlock(TextBlock b) => b.recognizedLanguages.contains('en');

bool _isValidBlock(TextBlock b) => !_isLargeBlock(b) && _isEnglishBlock(b);

String _trimLine(String s) => s
    .replaceAll(RegExp(r"^[^A-z0-9]+"), "")
    .replaceAll(RegExp(r"[^A-z0-9]+$"), "");

Iterable<String> eligibleMerchantLines(RecognizedText rt) => rt.blocks
    .where(_isValidBlock)
    .expand((b) => b.lines)
    .where((line) => line.elements.length <= 5)
    .map((line) => line.text)
    .map(_trimLine);

final _suffixPatterns = [
  RegExp(r"\bCo\.?\b", caseSensitive: false),
  RegExp(r"\bCompany", caseSensitive: false),
  RegExp(r"\bCorp", caseSensitive: false),
  RegExp(r"\bGroup", caseSensitive: false),
  RegExp(r"\bHoldings", caseSensitive: false),
  RegExp(r"\bLimited", caseSensitive: false),
  RegExp(r"\bLtd", caseSensitive: false),
  RegExp(r"\bUnlimited", caseSensitive: false),
  RegExp(r"& Son", caseSensitive: false),
  RegExp(r"\bL\.?L\.?C\.?", caseSensitive: false),
];

bool _hasSuffix(String s) => _suffixPatterns.any((r) => r.hasMatch(s));

Option<String> findMerchantWithSuffix(Iterable<String> lines) =>
    lines.where(_hasSuffix).firstOption;

final _noiseWords = [
  'accept',
  'card',
  'conditions',
  'credit',
  'eftpos',
  'gst',
  'invoice',
  'online',
  'purchase',
  'receipt',
  'register',
  'sale',
  'store',
  'tax',
  'tender',
  'terms',
  'thank you',
  'total',
  'www',
  '\\.co',
];

final _noisePatterns = [
  RegExp(r"^[^A-z0-9. ']"),
  RegExp(r"[0-9]$"),
  RegExp(
    _noiseWords.join("|"),
    caseSensitive: false,
  ),
];

bool _hasNoNoise(String s) => !_noisePatterns.any((r) => r.hasMatch(s));

int _moneyToMillis(MoneyEntity e) =>
    (e.integerPart * 1000) + (e.fractionPart * 10);

Option<int> extractBalance(List<EntityAnnotation> e) => e
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

Option<DateTime> extractExpires(List<EntityAnnotation> e) =>
    _extractDateTimes(e).where((dt) => dt.isFuture).lastOption;
