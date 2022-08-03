import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vouchervault/app/settings.dart';
import 'package:vouchervault/lib/riverpod.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final loggerProvider = Provider.family((ref, String file) => Logger(file));

final settingsProvider = persistedStateNotifierProvider(
  create: (ref, iv) => SettingsNotifier(iv ?? const VoucherVaultSettings()),
  key: 'settingsProvider',
  fromJson: VoucherVaultSettings.fromJson,
  toJson: (s) => s.toJson(),
);
