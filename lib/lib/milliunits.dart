import 'package:fpdt/function.dart';
import 'package:fpdt/option.dart';
import 'package:vouchervault/lib/option.dart';

int fromDouble(double i) => (i * 1000).round();

final fromNullableDouble = fromNullableWith<double>().compose(map(fromDouble));

final fromString = maybeParseDouble.compose(map(fromDouble));

double toDouble(int units) => units / 1000.0;

final maybeToDouble = fromNullableWith<int>().compose(map(toDouble));

final toString = maybeToDouble.compose(map((d) => d.toStringAsFixed(2)));
