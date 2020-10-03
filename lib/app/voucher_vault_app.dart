import 'package:flutter/material.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

class VoucherVaultApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.build(),
      home: VouchersScreen(),
    );
  }
}
