import 'package:flutter/material.dart';
import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fpdt/fpdt.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget _voucherVaultApp(
  BuildContext context, {
  IList<Voucher>? vouchers,
  List<AtomInitialValue> initialValues = const [],
}) =>
    AtomScope(
      initialValues: [
        ...initialValues,
        if (vouchers != null)
          vouchersState.parent
              .withInitialValue(createVoucherSM(VouchersState(vouchers)))
      ],
      child: const _App(),
    );

@swidget
Widget __app() => AtomBuilder((context, watch, child) {
      final auth = watch(authState);

      return MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: auth.when(
          unauthenticated: () => const AuthScreen(),
          authenticated: (_) => const VouchersScreen(),
        ),
        navigatorObservers: [routeObserver],
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
        ],
      );
    });
