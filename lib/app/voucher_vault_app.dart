import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/auth/index.dart';
import 'package:vouchervault/vouchers/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget _voucherVaultApp(
  BuildContext context, {
  List<AtomInitialValue> initialValues = const [],
}) =>
    AtomScope(
      initialValues: initialValues,
      child: const _App(),
    );

@swidget
Widget __app() {
  return DynamicColorBuilder(builder: (lightThemeSystem, darkThemeSystem) {
    final lightTheme = lightThemeSystem ??
        ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.red,
        );
    final darkTheme = darkThemeSystem ??
        ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.red,
        );

    return AtomBuilder((context, watch, child) {
      final auth = watch(authState);

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.build(lightTheme),
        darkTheme: AppTheme.build(darkTheme),
        home: auth.when(
          unauthenticated: () => const AuthScreen(),
          authenticated: (_) => const VouchersScreen(),
        ),
        navigatorObservers: [routeObserver],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    });
  });
}
