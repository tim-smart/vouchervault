import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/hooks/index.dart';

part 'app_scaffold.g.dart';

@hwidget
Widget appScaffold(
  BuildContext context, {
  required String title,
  required List<Widget> slivers,
  List<Widget> actions = const [],
  Option<Widget> floatingActionButton = const None(),
  bool leading = false,
}) {
  final theme = Theme.of(context);
  final style = useSystemOverlayStyle();

  return Scaffold(
    body: AnnotatedRegion(
      value: style,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: style,
            actions: actions,
            pinned: true,
            expandedHeight: AppTheme.rem(5),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsetsDirectional.only(
                start: leading ? AppTheme.rem(3) : AppTheme.space4,
                bottom: AppTheme.rem(0.75),
              ),
              title: Text(
                title,
                style: theme.textTheme.displayMedium!
                    .copyWith(fontSize: AppTheme.rem(1.2)),
              ),
            ),
          ),
          ...slivers,
        ],
      ),
    ),
    floatingActionButton: floatingActionButton.toNullable(),
  );
}
