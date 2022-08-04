import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';
import 'package:vouchervault/lib/lib.dart';

int millisFromDouble(double i) => (i * 1000).round();
double millisToDouble(int units) => units / 1000.0;

final millisFromNullableDouble =
    fromNullableWith<double>().c(map(millisFromDouble));

final millisFromString = maybeParseDouble.c(map(millisFromDouble));

final maybeMillisToDouble = fromNullableWith<int>().c(map(millisToDouble));

final millisToString = maybeMillisToDouble.c(map((d) => d.toStringAsFixed(2)));
