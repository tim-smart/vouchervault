import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main({IList<Voucher>? vouchers}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) =>
      // ignore: avoid_print
      print('${r.loggerName}: ${r.level.name}: ${r.time}: ${r.message}'));

  final prefs = await SharedPreferences.getInstance();

  runApp(VoucherVaultApp(
    vouchers: vouchers,
    initialValues: [sharedPrefs.withInitialValue(prefs)],
  ));
}
