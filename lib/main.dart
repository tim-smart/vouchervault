import 'package:flutter/material.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';

void main({
  List<Voucher>? vouchers,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  PersistedBlocStream.storage = await SharedPreferencesStorage.build();
  runApp(VoucherVaultApp(vouchers: vouchers));
}
