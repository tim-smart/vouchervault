import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/auth/index.dart';
import 'package:vouchervault/shared/scaffold/app_scaffold_simple.dart';

part 'auth_screen.g.dart';

@hwidget
Widget authScreen(BuildContext context) {
  final authenticate = useZIO(authLayer.accessWithZIO((_) => _.authenticate));

  useEffect(() {
    authenticate();
    return null;
  }, []);

  return AppScaffoldSimple(
    body: Center(
      child: ElevatedButton(
        onPressed: authenticate,
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
