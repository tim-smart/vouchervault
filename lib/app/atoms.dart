import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vouchervault/app/app.dart';

final sharedPrefs = atom<SharedPreferences>((get) => throw UnimplementedError())
  ..keepAlive();

final nucleusStorage = atom((get) => SharedPrefsStorage(get(sharedPrefs)));

final appSettings = stateAtomWithStorage(
  const VoucherVaultSettings(),
  key: 'rp_persist_settingsProvider',
  storage: nucleusStorage,
  fromJson: VoucherVaultSettings.fromJson,
  toJson: (s) => s.toJson(),
);
