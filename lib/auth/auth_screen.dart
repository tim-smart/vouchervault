import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth_bloc.dart';

part 'auth_screen.g.dart';

@hcwidget
Widget authScreen(WidgetRef ref) {
  final bloc = ref.watch(authBlocProvider.bloc);
  useEffect(() {
    bloc.add(AuthActions.authenticate());
  }, [bloc]);

  return Scaffold(
    backgroundColor: AppColors.background,
    body: Center(
      child: ElevatedButton(
        onPressed: () => bloc.add(AuthActions.authenticate()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_open),
            SizedBox(width: AppTheme.space2),
            Text('Unlock'),
          ],
        ),
      ),
    ),
  );

  /* return AppScaffold( */
  /*   title: 'Unlock', */
  /*   slivers: [ */
  /*     SliverPadding( */
  /*       padding: EdgeInsets.only( */
  /*         top: AppTheme.space3, */
  /*         bottom: AppTheme.space6, */
  /*       ), */
  /*       sliver: SliverFillRemaining( */
  /*         hasScrollBody: false, */
  /*         fillOverscroll: false, */
  /*         child: Center( */
  /*           child: ElevatedButton( */
  /*             onPressed: () => bloc.add(AuthActions.authenticate()), */
  /*             child: Row( */
  /*               mainAxisSize: MainAxisSize.min, */
  /*               children: [ */
  /*                 const Icon(Icons.lock_open), */
  /*                 SizedBox(width: AppTheme.space2), */
  /*                 Text('Unlock'), */
  /*               ], */
  /*             ), */
  /*           ), */
  /*         ), */
  /*       ), */
  /*     ), */
  /*   ], */
  /* ); */
}
