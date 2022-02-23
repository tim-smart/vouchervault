import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';

final optionOfString = fromNullableWith<String>()
    .c(map((s) => s.trim()))
    .c(filter((s) => s.isNotEmpty));

final maybeParseInt = optionOfString.c(chainNullableK(int.tryParse));

final maybeParseDouble = optionOfString.c(chainNullableK(double.tryParse));

Iterable<B> Function(Option<A>) ifSomeList<A, B>(Iterable<B> Function(A a) f) =>
    fold(() => [], f);
