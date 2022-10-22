import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

// === Merchant extraction
Option<String> extractMerchant(RecognizedText rt) {
  final lines = _eligibleMerchantLines(rt);
  final suffixMerchant =
      _findLineWithMerchantSuffix(lines).p(O.map(_removeSuffix));

  return suffixMerchant
      .p(O.alt(() => lines.firstOption))
      .p(O.map((s) => s.toLowerCase().titleCase));
}

Iterable<String> _eligibleMerchantLines(RecognizedText rt) => rt.blocks
    .where(_isValidBlock)
    .expand((b) => b.lines)
    .where((line) => line.elements.length <= 5)
    .map((line) => line.text)
    .map(_trimLine)
    .where(_hasNoNoise)
    .map(_normalizeWhitespace)
    .where(_hasNWords(4));

bool _isLargeBlock(TextBlock b) =>
    b.lines.length >= 5 || b.lines.any((l) => l.elements.length >= 7);

bool _isEnglishBlock(TextBlock b) => b.recognizedLanguages.contains('en');

bool _isValidBlock(TextBlock b) => !_isLargeBlock(b) && _isEnglishBlock(b);

String _trimLine(String s) => s
    .replaceAll(RegExp(r"^[^\p{L}]+", unicode: true), "")
    .replaceAll(RegExp(r"[^\p{L}]+$", unicode: true), "");

final _suffixPatterns = [
  RegExp(r"\bCo\.?\b", caseSensitive: false),
  RegExp(r"\bCompany", caseSensitive: false),
  RegExp(r"\bCorp", caseSensitive: false),
  RegExp(r"\bGroup", caseSensitive: false),
  RegExp(r"\bHoldings", caseSensitive: false),
  RegExp(r"\bInc\.?\b", caseSensitive: false),
  RegExp(r"\bLimited", caseSensitive: false),
  RegExp(r"\bLtd", caseSensitive: false),
  RegExp(r"\bUnlimited", caseSensitive: false),
  RegExp(r"& Son", caseSensitive: false),
  RegExp(r"\bL\.?L\.?C\.?", caseSensitive: false),
];

bool _hasSuffix(String s) => _suffixPatterns.any((r) => r.hasMatch(s));

Option<String> _findLineWithMerchantSuffix(Iterable<String> lines) =>
    lines.where(_hasSuffix).firstOption;

String _removeSuffix(String s) =>
    _suffixPatterns.fold(s, (s, re) => s.replaceAll(re, '').trim());

final _noiseWords = [
  'accept',
  'balance',
  'card',
  'cash',
  'cheque',
  'condition',
  'credit',
  'details',
  'discount',
  'eftpos',
  'enquir',
  'expires',
  'gst',
  'inquiry',
  'invoice',
  'online',
  'price',
  'promo',
  'purchase',
  'receipt',
  'redeem',
  'register',
  'sale',
  'tax',
  'tender',
  'terms',
  'thank you',
  'total',
  'voucher',
  'www',
  '\\.co',
];

final _noisePatterns = [
  RegExp(r"[^\p{L}'. ]", unicode: true),
  RegExp(
    _noiseWords.join("|"),
    caseSensitive: false,
  ),
];

bool _hasNoNoise(String s) => !_noisePatterns.any((r) => r.hasMatch(s));

String _normalizeWhitespace(String s) => s.replaceAll(RegExp(r"\s+"), " ");

bool Function(String) _hasNWords(int count) =>
    (s) => s.split(" ").length <= count;

// === Balance extraction
Option<int> extractBalance(List<EntityAnnotation> e) => e
    .expand((e) => e.entities)
    .where((e) => e.type == EntityType.money)
    .cast<MoneyEntity>()
    .map(_moneyToMillis)
    .toIList()
    .sort()
    .lastOption;

int _moneyToMillis(MoneyEntity e) =>
    (e.integerPart * 1000) + (e.fractionPart * 10);

// === Expiry extraction
Option<DateTime> extractExpires(
  RecognizedText text,
  List<EntityAnnotation> e,
) =>
    _extractDateTimes(e)
        .where((dt) => dt.isFuture)
        .followedBy(_extractDateTimesFromText(text))
        .lastOption;

final _datePatterns = <Tuple2<RegExp, DateTime? Function(String)>>[
  tuple2(RegExp(r"\d{1,2}[-/]\d{1,2}[-/]\s{2,4}"),
      (match) => DateFormat.yMd().parseLoose(match)),
  tuple2(
    RegExp(r"\d{1,2} [a-z]{3} \d{2,4}", caseSensitive: false),
    (match) => DateFormat('d MMM y').parseLoose(match),
  ),
];

final _dateMispellings = {
  '0ct': 'oct',
  'n0v': 'nov',
};

List<DateTime> _extractDateTimesFromText(RecognizedText rt) {
  final text = _dateMispellings.entries.fold(
    rt.text.toLowerCase(),
    (String text, e) => text.replaceAll(e.key, e.value),
  );

  return _datePatterns
      .map((t) => O
          .fromNullable(t.first.firstMatch(text)?[0])
          .p(O.chainNullableK(t.second))
          .p(O.toNullable))
      .where((dt) => dt != null)
      .toList()
      .cast();
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

DateTime _toDateTime(DateTimeEntity e) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(e.timestamp);

  return e.dateTimeGranularity == DateTimeGranularity.month
      ? dateTime.endOfMonth
      : dateTime;
}
