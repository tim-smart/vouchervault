import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';

IOOption<A> navPush<A>(BuildContext context, Route<A> Function() route) =>
    IOOption.unsafeFuture(() => Navigator.push(context, route()))
        .flatMapNullable(identity);

IOOption<A> showDialogTO<A>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) =>
    IOOption.unsafeFuture(
      () => showDialog<A>(context: context, builder: builder),
    ).flatMapNullable(identity);
