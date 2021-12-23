import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth_bloc.dart';
import 'package:vouchervault/auth/auth_screen.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget voucherVaultApp(
  BuildContext context, {
  IList<Voucher>? vouchers,
  List<Override> overrides = const [],
}) =>
    ProviderScope(
      overrides: [
        ...overrides,
        if (vouchers != null)
          vouchersProvider.overrideWithValue(
              VouchersBloc(initialValue: VouchersState(vouchers))),
      ],
      child: const _App(),
    );

@hcwidget
Widget _app(WidgetRef ref) {
  // Remove expired vouchers
  final bloc = ref.watch(vouchersProvider.bloc);
  useEffect(() {
    bloc.add(removeExpiredVouchers());
  }, [bloc]);

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
