import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/task.dart' as T;

TaskOption<A> navPush<A>(BuildContext context, Lazy<Route<A>> route) =>
    (() => Navigator.push(context, route())).p(T.map(O.fromNullable));

TaskOption<A> showDialogTO<A>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) =>
    (() => showDialog<A>(context: context, builder: builder))
        .p(T.map(O.fromNullable));
