import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';

Option<String> optionOfString(String? s) =>
    fromNullable(s).chain(filter((s) => s.isNotEmpty));
