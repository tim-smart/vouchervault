import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/shared/scaffold/app_scaffold_simple.dart';

part 'auth_screen.g.dart';

@hwidget
Widget authScreen() {
  final sm = useAtom(authState.parent);
  useEffect(() {
    sm.run(authenticate);
    return null;
  }, [sm]);

  return AppScaffoldSimple(
    body: Center(
      child: ElevatedButton(
        onPressed: () => sm.run(authenticate),
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
