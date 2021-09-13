// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
class _$VoucherTearOff {
  const _$VoucherTearOff();

  _Voucher call(
      {String? uuid,
      String description = '',
      String? code,
      VoucherCodeType codeType = VoucherCodeType.CODE128,
      DateTime? expires,
      bool removeOnceExpired = true,
      double? balance,
      int? balanceMilliunits,
      VoucherColor color = VoucherColor.GREY}) {
    return _Voucher(
      uuid: uuid,
      description: description,
      code: code,
      codeType: codeType,
      expires: expires,
      removeOnceExpired: removeOnceExpired,
      balance: balance,
      balanceMilliunits: balanceMilliunits,
      color: color,
    );
  }

  Voucher fromJson(Map<String, Object> json) {
    return Voucher.fromJson(json);
  }
}

/// @nodoc
const $Voucher = _$VoucherTearOff();

/// @nodoc
mixin _$Voucher {
  String? get uuid => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  VoucherCodeType get codeType => throw _privateConstructorUsedError;
  DateTime? get expires => throw _privateConstructorUsedError;
  bool get removeOnceExpired => throw _privateConstructorUsedError;
  double? get balance => throw _privateConstructorUsedError;
  int? get balanceMilliunits => throw _privateConstructorUsedError;
  VoucherColor get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res>;
  $Res call(
      {String? uuid,
      String description,
      String? code,
      VoucherCodeType codeType,
      DateTime? expires,
      bool removeOnceExpired,
      double? balance,
      int? balanceMilliunits,
      VoucherColor color});
}

/// @nodoc
class _$VoucherCopyWithImpl<$Res> implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._value, this._then);

  final Voucher _value;
  // ignore: unused_field
  final $Res Function(Voucher) _then;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? description = freezed,
    Object? code = freezed,
    Object? codeType = freezed,
    Object? expires = freezed,
    Object? removeOnceExpired = freezed,
    Object? balance = freezed,
    Object? balanceMilliunits = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      codeType: codeType == freezed
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: expires == freezed
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removeOnceExpired: removeOnceExpired == freezed
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
      balanceMilliunits: balanceMilliunits == freezed
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as VoucherColor,
    ));
  }
}

/// @nodoc
abstract class _$VoucherCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$VoucherCopyWith(_Voucher value, $Res Function(_Voucher) then) =
      __$VoucherCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? uuid,
      String description,
      String? code,
      VoucherCodeType codeType,
      DateTime? expires,
      bool removeOnceExpired,
      double? balance,
      int? balanceMilliunits,
      VoucherColor color});
}

/// @nodoc
class __$VoucherCopyWithImpl<$Res> extends _$VoucherCopyWithImpl<$Res>
    implements _$VoucherCopyWith<$Res> {
  __$VoucherCopyWithImpl(_Voucher _value, $Res Function(_Voucher) _then)
      : super(_value, (v) => _then(v as _Voucher));

  @override
  _Voucher get _value => super._value as _Voucher;

  @override
  $Res call({
    Object? uuid = freezed,
    Object? description = freezed,
    Object? code = freezed,
    Object? codeType = freezed,
    Object? expires = freezed,
    Object? removeOnceExpired = freezed,
    Object? balance = freezed,
    Object? balanceMilliunits = freezed,
    Object? color = freezed,
  }) {
    return _then(_Voucher(
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      codeType: codeType == freezed
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: expires == freezed
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removeOnceExpired: removeOnceExpired == freezed
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: balance == freezed
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
      balanceMilliunits: balanceMilliunits == freezed
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as VoucherColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Voucher extends _Voucher {
  _$_Voucher(
      {this.uuid,
      this.description = '',
      this.code,
      this.codeType = VoucherCodeType.CODE128,
      this.expires,
      this.removeOnceExpired = true,
      this.balance,
      this.balanceMilliunits,
      this.color = VoucherColor.GREY})
      : super._();

  factory _$_Voucher.fromJson(Map<String, dynamic> json) =>
      _$$_VoucherFromJson(json);

  @override
  final String? uuid;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @override
  final String? code;
  @JsonKey(defaultValue: VoucherCodeType.CODE128)
  @override
  final VoucherCodeType codeType;
  @override
  final DateTime? expires;
  @JsonKey(defaultValue: true)
  @override
  final bool removeOnceExpired;
  @override
  final double? balance;
  @override
  final int? balanceMilliunits;
  @JsonKey(defaultValue: VoucherColor.GREY)
  @override
  final VoucherColor color;

  @override
  String toString() {
    return 'Voucher(uuid: $uuid, description: $description, code: $code, codeType: $codeType, expires: $expires, removeOnceExpired: $removeOnceExpired, balance: $balance, balanceMilliunits: $balanceMilliunits, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Voucher &&
            (identical(other.uuid, uuid) ||
                const DeepCollectionEquality().equals(other.uuid, uuid)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.codeType, codeType) ||
                const DeepCollectionEquality()
                    .equals(other.codeType, codeType)) &&
            (identical(other.expires, expires) ||
                const DeepCollectionEquality()
                    .equals(other.expires, expires)) &&
            (identical(other.removeOnceExpired, removeOnceExpired) ||
                const DeepCollectionEquality()
                    .equals(other.removeOnceExpired, removeOnceExpired)) &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.balanceMilliunits, balanceMilliunits) ||
                const DeepCollectionEquality()
                    .equals(other.balanceMilliunits, balanceMilliunits)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uuid) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(codeType) ^
      const DeepCollectionEquality().hash(expires) ^
      const DeepCollectionEquality().hash(removeOnceExpired) ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(balanceMilliunits) ^
      const DeepCollectionEquality().hash(color);

  @JsonKey(ignore: true)
  @override
  _$VoucherCopyWith<_Voucher> get copyWith =>
      __$VoucherCopyWithImpl<_Voucher>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoucherToJson(this);
  }
}

abstract class _Voucher extends Voucher {
  factory _Voucher(
      {String? uuid,
      String description,
      String? code,
      VoucherCodeType codeType,
      DateTime? expires,
      bool removeOnceExpired,
      double? balance,
      int? balanceMilliunits,
      VoucherColor color}) = _$_Voucher;
  _Voucher._() : super._();

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$_Voucher.fromJson;

  @override
  String? get uuid => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String? get code => throw _privateConstructorUsedError;
  @override
  VoucherCodeType get codeType => throw _privateConstructorUsedError;
  @override
  DateTime? get expires => throw _privateConstructorUsedError;
  @override
  bool get removeOnceExpired => throw _privateConstructorUsedError;
  @override
  double? get balance => throw _privateConstructorUsedError;
  @override
  int? get balanceMilliunits => throw _privateConstructorUsedError;
  @override
  VoucherColor get color => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$VoucherCopyWith<_Voucher> get copyWith =>
      throw _privateConstructorUsedError;
}
