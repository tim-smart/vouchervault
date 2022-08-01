import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/hooks/use_system_overlay_style.dart';

part 'app_scaffold_simple.g.dart';

@hwidget
Widget appScaffoldSimple(
  BuildContext context, {
  required Widget body,
}) {
  final style = useSystemOverlayStyle();
  return AnnotatedRegion(
    value: style,
    child: Scaffold(body: body),
  );
}
