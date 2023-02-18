// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VoucherVaultSettings _$VoucherVaultSettingsFromJson(Map<String, dynamic> json) {
  return _VoucherVaultSettings.fromJson(json);
}

/// @nodoc
mixin _$VoucherVaultSettings {
  bool get smartScan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherVaultSettingsCopyWith<VoucherVaultSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherVaultSettingsCopyWith<$Res> {
  factory $VoucherVaultSettingsCopyWith(VoucherVaultSettings value,
          $Res Function(VoucherVaultSettings) then) =
      _$VoucherVaultSettingsCopyWithImpl<$Res, VoucherVaultSettings>;
  @useResult
  $Res call({bool smartScan});
}

/// @nodoc
class _$VoucherVaultSettingsCopyWithImpl<$Res,
        $Val extends VoucherVaultSettings>
    implements $VoucherVaultSettingsCopyWith<$Res> {
  _$VoucherVaultSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smartScan = null,
  }) {
    return _then(_value.copyWith(
      smartScan: null == smartScan
          ? _value.smartScan
          : smartScan // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VoucherVaultSettingsCopyWith<$Res>
    implements $VoucherVaultSettingsCopyWith<$Res> {
  factory _$$_VoucherVaultSettingsCopyWith(_$_VoucherVaultSettings value,
          $Res Function(_$_VoucherVaultSettings) then) =
      __$$_VoucherVaultSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool smartScan});
}

/// @nodoc
class __$$_VoucherVaultSettingsCopyWithImpl<$Res>
    extends _$VoucherVaultSettingsCopyWithImpl<$Res, _$_VoucherVaultSettings>
    implements _$$_VoucherVaultSettingsCopyWith<$Res> {
  __$$_VoucherVaultSettingsCopyWithImpl(_$_VoucherVaultSettings _value,
      $Res Function(_$_VoucherVaultSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smartScan = null,
  }) {
    return _then(_$_VoucherVaultSettings(
      smartScan: null == smartScan
          ? _value.smartScan
          : smartScan // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VoucherVaultSettings implements _VoucherVaultSettings {
  const _$_VoucherVaultSettings({this.smartScan = true});

  factory _$_VoucherVaultSettings.fromJson(Map<String, dynamic> json) =>
      _$$_VoucherVaultSettingsFromJson(json);

  @override
  @JsonKey()
  final bool smartScan;

  @override
  String toString() {
    return 'VoucherVaultSettings(smartScan: $smartScan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VoucherVaultSettings &&
            (identical(other.smartScan, smartScan) ||
                other.smartScan == smartScan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, smartScan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VoucherVaultSettingsCopyWith<_$_VoucherVaultSettings> get copyWith =>
      __$$_VoucherVaultSettingsCopyWithImpl<_$_VoucherVaultSettings>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoucherVaultSettingsToJson(
      this,
    );
  }
}

abstract class _VoucherVaultSettings implements VoucherVaultSettings {
  const factory _VoucherVaultSettings({final bool smartScan}) =
      _$_VoucherVaultSettings;

  factory _VoucherVaultSettings.fromJson(Map<String, dynamic> json) =
      _$_VoucherVaultSettings.fromJson;

  @override
  bool get smartScan;
  @override
  @JsonKey(ignore: true)
  _$$_VoucherVaultSettingsCopyWith<_$_VoucherVaultSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
