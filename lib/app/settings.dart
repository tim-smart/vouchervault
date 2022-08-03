import 'package:freezed_annotation/freezed_annotation.dart';

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
