import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/task_option.dart' as TO;

TaskOption<A> navPush<A>(BuildContext context, Lazy<Route<A>> route) => TO
    .fromTask(Task(() => Navigator.push(context, route())))
    .p(TO.chainNullableK(identity));

TaskOption<A> showDialogTO<A>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) =>
    TO
        .fromTask(Task(() => showDialog<A>(context: context, builder: builder)))
        .p(TO.chainNullableK(identity));
