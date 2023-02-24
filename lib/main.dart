import 'package:flutter/material.dart';
import 'package:flutter_elemental/flutter_elemental.dart' hide Logger;
import 'package:logging/logging.dart';
import 'package:vouchervault/app/index.dart';
import 'package:vouchervault/auth/index.dart';
import 'package:vouchervault/vouchers/index.dart';

void main({IList<Voucher>? vouchers}) async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((r) =>
      // ignore: avoid_print
      print('${r.loggerName}: ${r.level.name}: ${r.time}: ${r.message}'));

  final runtime = await runtimeInitialValue([
    sharedPrefsLayer,
    authLayer,
    if (vouchers != null)
      vouchersLayer.replace(IO.succeed(VouchersService(
        ref: Ref.unsafeMake(VouchersState(vouchers)),
      )))
    else
      vouchersLayer,
  ]);

  runApp(VoucherVaultApp(initialValues: [runtime]));
}
