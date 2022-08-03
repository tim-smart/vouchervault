import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:fpdt/option.dart' show Option;
import 'package:fpdt/option.dart' as O;
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/hooks/use_system_overlay_style.dart';

part 'app_scaffold.g.dart';

@hwidget
Widget appScaffold(
  BuildContext context, {
  required String title,
  required List<Widget> slivers,
  List<Widget> actions = const [],
  Option<Widget> floatingActionButton = O.kNone,
  bool leading = false,
}) {
  final theme = Theme.of(context);
  final style = useSystemOverlayStyle();

  return AnnotatedRegion(
    value: style,
    child: Scaffold(
      body: CustomScrollView(
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
                style: theme.textTheme.headline2!
                    .copyWith(fontSize: AppTheme.rem(1.2)),
              ),
            ),
          ),
          ...slivers,
        ],
      ),
      floatingActionButton: O.toNullable(floatingActionButton),
    ),
  );
}
