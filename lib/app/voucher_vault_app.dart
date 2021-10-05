import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/auth/auth_bloc.dart';
import 'package:vouchervault/auth/auth_screen.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/vouchers/vouchers.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget voucherVaultApp(
  BuildContext context, {
  IList<Voucher>? vouchers,
}) =>
    ProviderScope(
      overrides: [
        if (vouchers != null)
          vouchersProvider
              .overrideWithValue(VouchersBloc(VouchersState(vouchers)))
      ],
      child: _App(),
    );

@hcwidget
Widget _app(WidgetRef ref) {
  // Remove expired vouchers
  final bloc = ref.watch(vouchersProvider.bloc);
  useEffect(() {
    bloc.add(VoucherActions.removeExpired());
  }, [bloc]);

  // Auth state
  final authState = ref.watch(authBlocProvider);

  return MaterialApp(
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: authState.when(
      unauthenticated: () => AuthScreen(),
      authenticated: (_) => VouchersScreen(),
    ),
    navigatorObservers: [routeObserver],
  );
}
