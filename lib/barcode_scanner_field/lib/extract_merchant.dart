import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
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
