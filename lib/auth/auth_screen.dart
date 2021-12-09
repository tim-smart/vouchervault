import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold_simple.dart';
import 'package:vouchervault/auth/auth_bloc.dart';

part 'auth_screen.g.dart';

@hcwidget
Widget authScreen(WidgetRef ref) {
  final iter = ref.watch(authIteratorProvider);
  useEffect(() {
    iter.add(AuthActions.authenticate(ref));
  }, [iter]);

  return AppScaffoldSimple(
    body: Center(
      child: ElevatedButton(
        onPressed: () => iter.add(AuthActions.authenticate(ref)),
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
}
