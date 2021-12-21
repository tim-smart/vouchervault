import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';
import 'package:vouchervault/lib/option.dart';

int fromDouble(double i) => (i * 1000).round();
double toDouble(int units) => units / 1000.0;

final fromNullableDouble = fromNullableWith<double>().c(map(fromDouble));

final fromString = maybeParseDouble.c(map(fromDouble));

final maybeToDouble = fromNullableWith<int>().c(map(toDouble));

final toString = maybeToDouble.c(map((d) => d.toStringAsFixed(2)));
