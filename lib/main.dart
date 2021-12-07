import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:offset_iterator_persist/offset_iterator_persist.dart'
    as persist;
import 'package:persisted_bloc_stream/persisted_bloc_stream.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/models/voucher.dart';

void main({IList<Voucher>? vouchers}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) =>
      print('${r.loggerName}: ${r.level.name}: ${r.time}: ${r.message}'));

  PersistedBlocStream.storage = await SharedPreferencesStorage.build();
  final storage = await persist.HiveStorage.build();

  runApp(VoucherVaultApp(
    vouchers: vouchers,
    overrides: [storageProvider.overrideWithValue(storage)],
  ));
}
