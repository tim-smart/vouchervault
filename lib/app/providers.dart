import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_persistence/riverpod_persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vouchervault/app/settings.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final loggerProvider = Provider.family((ref, String file) => Logger(file));

final settingsProvider = persistStateProvider(
  initialValue: const VoucherVaultSettings(),
  buildStorage: (ref) => SharedPreferencesStorage(
    key: 'settingsProvider',
    fromJson: VoucherVaultSettings.fromJson,
    toJson: (s) => s.toJson(),
    instance: ref.watch(sharedPreferencesProvider),
  ),
);
