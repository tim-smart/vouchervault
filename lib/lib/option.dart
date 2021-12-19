import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';

Option<String> optionOfString(String? s) =>
    fromNullable(s).p(filter((s) => s.isNotEmpty));

final maybeParseInt = optionOfString.c(chainNullableK(int.tryParse));
final maybeParseDouble = optionOfString.c(chainNullableK(double.tryParse));
