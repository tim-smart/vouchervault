import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';
import 'package:vouchervault/lib/lib.dart';

int millisFromDouble(double i) => (i * 1000).round();
double millisToDouble(int units) => units / 1000.0;
String millisToString(int i) => millisToDouble(i).toStringAsFixed(2);

final millisFromNullableDouble =
    fromNullableWith<double>().c(map(millisFromDouble));

final millisFromString = maybeParseDouble.c(map(millisFromDouble));

Option<double> maybeMillisToDouble(int? i) =>
    fromNullable(i).p(map(millisToDouble));

Option<String> maybeMillisToString(int? i) =>
    fromNullable(i).p(map(millisToString));
