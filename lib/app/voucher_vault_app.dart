import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth_screen.dart';
import 'package:vouchervault/auth/providers.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/vouchers/model.dart';
import 'package:vouchervault/vouchers/providers.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget _voucherVaultApp(
  BuildContext context, {
  IList<Voucher>? vouchers,
  List<Override> overrides = const [],
}) =>
    ProviderScope(
      overrides: [
        ...overrides,
        if (vouchers != null)
          vouchersSMProvider.overrideWithProvider(
            createVouchersSMProvider(VouchersState(vouchers)),
          ),
      ],
      child: const _App(),
    );

@hcwidget
Widget __app(WidgetRef ref) {
  // Auth state
  final authState = ref.watch(authProvider);

  return MaterialApp(
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: authState.when(
      unauthenticated: () => const AuthScreen(),
      authenticated: (_) => const VouchersScreen(),
    ),
    navigatorObservers: [routeObserver],
  );
}
