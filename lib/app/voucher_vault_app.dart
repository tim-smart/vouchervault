import 'package:flutter/material.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:provider/provider.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

class VoucherVaultApp extends StatelessWidget {
  Widget _buildProviders(Widget child) => MultiProvider(
        providers: [
          BlocStreamProvider(
              create: (context) => VouchersBloc()..add(VoucherActions.init)),
        ],
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return _buildProviders(MaterialApp(
      theme: AppTheme.build(),
      home: VouchersScreen(),
    ));
  }
}
