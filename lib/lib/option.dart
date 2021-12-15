import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';

Option<String> optionOfString(String? s) =>
    fromNullable(s).chain(filter((s) => s.isNotEmpty));

final maybeParseInt = optionOfString.compose(chainNullableK(int.tryParse));
final maybeParseDouble =
    optionOfString.compose(chainNullableK(double.tryParse));
