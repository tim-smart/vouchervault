import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:vouchervault/lib/lib.dart';

int millisFromDouble(double i) => (i * 1000).round();
double millisToDouble(int units) => units / 1000.0;
String millisToString(int i) => millisToDouble(i).toStringAsFixed(2);

Option<int> millisFromNullableDouble(double? i) =>
    Option.fromNullable(i).map(millisFromDouble);

Option<int> millisFromString(String? s) =>
    maybeParseDouble(s).map(millisFromDouble);

Option<double> maybeMillisToDouble(int? i) =>
    Option.fromNullable(i).map(millisToDouble);

Option<String> maybeMillisToString(int? i) =>
    Option.fromNullable(i).map(millisToString);
