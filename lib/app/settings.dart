import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class VoucherVaultSettings with _$VoucherVaultSettings {
  const factory VoucherVaultSettings({
    @Default(true) bool smartScan,
  }) = _VoucherVaultSettings;

  factory VoucherVaultSettings.fromJson(dynamic json) =>
      _$VoucherVaultSettingsFromJson(json);
}

class SettingsNotifier extends StateNotifier<VoucherVaultSettings> {
  SettingsNotifier(VoucherVaultSettings initialValue) : super(initialValue);

  void update(VoucherVaultSettings Function(VoucherVaultSettings s) f) =>
      state = f(state);
}
