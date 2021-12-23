import 'package:flutter/material.dart';
import 'package:fpdt/fpdt.dart';
import 'package:logging/logging.dart';
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';

void main({IList<Voucher>? vouchers}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) =>
      // ignore: avoid_print
      print('${r.loggerName}: ${r.level.name}: ${r.time}: ${r.message}'));

  PersistedBlocStream.storage = await SharedPreferencesStorage.build();

  runApp(VoucherVaultApp(vouchers: vouchers));
}
