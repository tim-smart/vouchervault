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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherVaultSettings _$VoucherVaultSettingsFromJson(Map<String, dynamic> json) {
  return _VoucherVaultSettings.fromJson(json);
}

/// @nodoc
mixin _$VoucherVaultSettings {
  bool get smartScan => throw _privateConstructorUsedError;

  /// Serializes this VoucherVaultSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoucherVaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of VoucherVaultSettings
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$VoucherVaultSettingsImplCopyWith<$Res>
    implements $VoucherVaultSettingsCopyWith<$Res> {
  factory _$$VoucherVaultSettingsImplCopyWith(_$VoucherVaultSettingsImpl value,
          $Res Function(_$VoucherVaultSettingsImpl) then) =
      __$$VoucherVaultSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool smartScan});
}

/// @nodoc
class __$$VoucherVaultSettingsImplCopyWithImpl<$Res>
    extends _$VoucherVaultSettingsCopyWithImpl<$Res, _$VoucherVaultSettingsImpl>
    implements _$$VoucherVaultSettingsImplCopyWith<$Res> {
  __$$VoucherVaultSettingsImplCopyWithImpl(_$VoucherVaultSettingsImpl _value,
      $Res Function(_$VoucherVaultSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoucherVaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smartScan = null,
  }) {
    return _then(_$VoucherVaultSettingsImpl(
      smartScan: null == smartScan
          ? _value.smartScan
          : smartScan // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherVaultSettingsImpl implements _VoucherVaultSettings {
  const _$VoucherVaultSettingsImpl({this.smartScan = true});

  factory _$VoucherVaultSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherVaultSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool smartScan;

  @override
  String toString() {
    return 'VoucherVaultSettings(smartScan: $smartScan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherVaultSettingsImpl &&
            (identical(other.smartScan, smartScan) ||
                other.smartScan == smartScan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, smartScan);

  /// Create a copy of VoucherVaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherVaultSettingsImplCopyWith<_$VoucherVaultSettingsImpl>
      get copyWith =>
          __$$VoucherVaultSettingsImplCopyWithImpl<_$VoucherVaultSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherVaultSettingsImplToJson(
      this,
    );
  }
}

abstract class _VoucherVaultSettings implements VoucherVaultSettings {
  const factory _VoucherVaultSettings({final bool smartScan}) =
      _$VoucherVaultSettingsImpl;

  factory _VoucherVaultSettings.fromJson(Map<String, dynamic> json) =
      _$VoucherVaultSettingsImpl.fromJson;

  @override
  bool get smartScan;

  /// Create a copy of VoucherVaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherVaultSettingsImplCopyWith<_$VoucherVaultSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
