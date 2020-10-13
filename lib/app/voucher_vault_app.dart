import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

part 'voucher_vault_app.g.dart';

@swidget
Widget voucherVaultApp() => MultiProvider(
      providers: [
        BlocStreamProvider(
          create: (context) => VouchersBloc()..add(VoucherActions.init),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.build(),
        home: VouchersScreen(),
      ),
    );
