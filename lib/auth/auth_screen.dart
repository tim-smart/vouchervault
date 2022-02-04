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
  final bloc = ref.watch(authProvider.bloc);
  useEffect(() {
    bloc.add(AuthActions.authenticate(ref.read));
    return null;
  }, [bloc]);

  return AppScaffoldSimple(
    body: Center(
      child: ElevatedButton(
        onPressed: () => bloc.add(AuthActions.authenticate(ref.read)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_open),
            SizedBox(width: AppTheme.space2),
            const Text('Unlock'),
          ],
        ),
      ),
    ),
  );
}
