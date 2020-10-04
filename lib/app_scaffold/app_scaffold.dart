import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:vouchervault/app/app.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold({
    Key key,
    @required this.title,
    @required this.slivers,
    this.actions = const None(),
    this.floatingActionButton = const None(),
    this.leading = false,
  });

  final String title;
  final List<Widget> slivers;
  final Option<List<Widget>> actions;
  final Option<Widget> floatingActionButton;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: actions | [],
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
      floatingActionButton: floatingActionButton | null,
    );
  }
}
