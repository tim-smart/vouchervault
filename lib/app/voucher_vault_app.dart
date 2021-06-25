import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/vouchers/vouchers.dart';
import 'package:vouchervault/vouchers/vouchers_bloc.dart';

part 'voucher_vault_app.g.dart';

final routeObserver = RouteObserver<ModalRoute>();

@swidget
Widget voucherVaultApp(
  BuildContext context, {
  List<Voucher>? vouchers,
}) =>
    ProviderScope(
      overrides: [
        if (vouchers != null)
          vouchersProvider
              .overrideWithValue(VouchersBloc(VouchersState(vouchers)))
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: VouchersScreen(),
        navigatorObservers: [routeObserver],
      ),
    );
