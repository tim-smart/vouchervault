import 'package:fpdart/fpdart.dart';

Option<String> optionOfString(String? s) =>
    optionOf(s).filter((s) => s.isNotEmpty);
