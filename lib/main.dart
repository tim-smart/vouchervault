import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/models/voucher.dart';

void main({IList<Voucher>? vouchers}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) =>
      // ignore: avoid_print
      print('${r.loggerName}: ${r.level.name}: ${r.time}: ${r.message}'));

  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(VoucherVaultApp(
    vouchers: vouchers,
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPrefs),
    ],
  ));
}
