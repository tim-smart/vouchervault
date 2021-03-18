import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'voucher_vault_app.g.dart';

@swidget
Widget voucherVaultApp() => ProviderScope(
      child: MaterialApp(
        theme: AppTheme.build(),
        home: VouchersScreen(),
      ),
    );
