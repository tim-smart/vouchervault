import 'package:dartz/dartz.dart';

Option<String> optionOfString(String? s) =>
    optionOf(s).bind((s) => s.isEmpty ? none() : some(s));
