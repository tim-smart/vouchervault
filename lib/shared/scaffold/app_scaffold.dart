import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/hooks/index.dart';

part 'app_scaffold.g.dart';

@hwidget
Widget appScaffold(
  BuildContext context, {
  required String title,
  required List<Widget> slivers,
  List<Widget> actions = const [],
  Option<Widget> floatingActionButton = const Option.none(),
  bool leading = false,
}) {
  final style = useSystemOverlayStyle();

  return Scaffold(
    body: AnnotatedRegion(
      value: style,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            systemOverlayStyle: style,
            actions: actions,
            title: Text(title),
          ),
        ],
        body: CustomScrollView(slivers: slivers),
      ),
    ),
    floatingActionButton: floatingActionButton.toNullable(),
  );
}
