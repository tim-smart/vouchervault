import 'package:flutter_elemental/flutter_elemental.dart';

Option<String> optionOfString(String? s) =>
    Option.fromNullable(s).map((s) => s.trim()).filter((s) => s.isNotEmpty);

final maybeParseInt = optionOfString
    .c((_) => _.flatMap((_) => Option.fromNullable(int.tryParse(_))));

final maybeParseDouble = optionOfString
    .c((_) => _.flatMap((_) => Option.fromNullable(double.tryParse(_))));

extension IfSomeListExt<A> on Option<A> {
  Iterable<B> ifSomeList<B>(Iterable<B> Function(A a) f) => match(() => [], f);
}
