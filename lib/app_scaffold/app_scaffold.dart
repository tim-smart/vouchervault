import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';

part 'app_scaffold.g.dart';

@swidget
Widget appScaffold(
  BuildContext context, {
  @required String title,
  @required List<Widget> slivers,
  List<Widget> actions = const [],
  Option<Widget> floatingActionButton = const None(),
  bool leading = false,
}) {
  final theme = Theme.of(context);
  final style = SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(style);

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
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
              style: theme.textTheme.headline2
                  .copyWith(fontSize: AppTheme.rem(1.2)),
            ),
          ),
        ),
        ...slivers,
      ],
    ),
    floatingActionButton: floatingActionButton.toNullable(),
  );
}
