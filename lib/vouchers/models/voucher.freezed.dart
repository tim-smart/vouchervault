// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
mixin _$Voucher {
  O.Option<String> get uuid => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  O.Option<String> get code => throw _privateConstructorUsedError;
  VoucherCodeType get codeType => throw _privateConstructorUsedError;
  O.Option<DateTime> get expires => throw _privateConstructorUsedError;
  bool get removeOnceExpired => throw _privateConstructorUsedError;
  O.Option<double> get balance => throw _privateConstructorUsedError;
  O.Option<int> get balanceMilliunits => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  VoucherColor get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res, Voucher>;
  @useResult
  $Res call(
      {O.Option<String> uuid,
      String description,
      O.Option<String> code,
      VoucherCodeType codeType,
      O.Option<DateTime> expires,
      bool removeOnceExpired,
      O.Option<double> balance,
      O.Option<int> balanceMilliunits,
      String notes,
      VoucherColor color});
}

/// @nodoc
class _$VoucherCopyWithImpl<$Res, $Val extends Voucher>
    implements $VoucherCopyWith<$Res> {
  _$VoucherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? description = null,
    Object? code = null,
    Object? codeType = null,
    Object? expires = null,
    Object? removeOnceExpired = null,
    Object? balance = null,
    Object? balanceMilliunits = null,
    Object? notes = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as O.Option<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as O.Option<String>,
      codeType: null == codeType
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as O.Option<DateTime>,
      removeOnceExpired: null == removeOnceExpired
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as O.Option<double>,
      balanceMilliunits: null == balanceMilliunits
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as O.Option<int>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as VoucherColor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VoucherCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$$_VoucherCopyWith(
          _$_Voucher value, $Res Function(_$_Voucher) then) =
      __$$_VoucherCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {O.Option<String> uuid,
      String description,
      O.Option<String> code,
      VoucherCodeType codeType,
      O.Option<DateTime> expires,
      bool removeOnceExpired,
      O.Option<double> balance,
      O.Option<int> balanceMilliunits,
      String notes,
      VoucherColor color});
}

/// @nodoc
class __$$_VoucherCopyWithImpl<$Res>
    extends _$VoucherCopyWithImpl<$Res, _$_Voucher>
    implements _$$_VoucherCopyWith<$Res> {
  __$$_VoucherCopyWithImpl(_$_Voucher _value, $Res Function(_$_Voucher) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? description = null,
    Object? code = null,
    Object? codeType = null,
    Object? expires = null,
    Object? removeOnceExpired = null,
    Object? balance = null,
    Object? balanceMilliunits = null,
    Object? notes = null,
    Object? color = null,
  }) {
    return _then(_$_Voucher(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as O.Option<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as O.Option<String>,
      codeType: null == codeType
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as O.Option<DateTime>,
      removeOnceExpired: null == removeOnceExpired
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as O.Option<double>,
      balanceMilliunits: null == balanceMilliunits
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as O.Option<int>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
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
      {this.uuid = O.kNone,
      this.description = '',
      this.code = O.kNone,
      this.codeType = VoucherCodeType.CODE128,
      this.expires = O.kNone,
      this.removeOnceExpired = true,
      this.balance = O.kNone,
      this.balanceMilliunits = O.kNone,
      this.notes = '',
      this.color = VoucherColor.GREY})
      : super._();

  factory _$_Voucher.fromJson(Map<String, dynamic> json) =>
      _$$_VoucherFromJson(json);

  @override
  @JsonKey()
  final O.Option<String> uuid;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final O.Option<String> code;
  @override
  @JsonKey()
  final VoucherCodeType codeType;
  @override
  @JsonKey()
  final O.Option<DateTime> expires;
  @override
  @JsonKey()
  final bool removeOnceExpired;
  @override
  @JsonKey()
  final O.Option<double> balance;
  @override
  @JsonKey()
  final O.Option<int> balanceMilliunits;
  @override
  @JsonKey()
  final String notes;
  @override
  @JsonKey()
  final VoucherColor color;

  @override
  String toString() {
    return 'Voucher(uuid: $uuid, description: $description, code: $code, codeType: $codeType, expires: $expires, removeOnceExpired: $removeOnceExpired, balance: $balance, balanceMilliunits: $balanceMilliunits, notes: $notes, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Voucher &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.codeType, codeType) ||
                other.codeType == codeType) &&
            (identical(other.expires, expires) || other.expires == expires) &&
            (identical(other.removeOnceExpired, removeOnceExpired) ||
                other.removeOnceExpired == removeOnceExpired) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.balanceMilliunits, balanceMilliunits) ||
                other.balanceMilliunits == balanceMilliunits) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uuid,
      description,
      code,
      codeType,
      expires,
      removeOnceExpired,
      balance,
      balanceMilliunits,
      notes,
      color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VoucherCopyWith<_$_Voucher> get copyWith =>
      __$$_VoucherCopyWithImpl<_$_Voucher>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoucherToJson(
      this,
    );
  }
}

abstract class _Voucher extends Voucher {
  factory _Voucher(
      {final O.Option<String> uuid,
      final String description,
      final O.Option<String> code,
      final VoucherCodeType codeType,
      final O.Option<DateTime> expires,
      final bool removeOnceExpired,
      final O.Option<double> balance,
      final O.Option<int> balanceMilliunits,
      final String notes,
      final VoucherColor color}) = _$_Voucher;
  _Voucher._() : super._();

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$_Voucher.fromJson;

  @override
  O.Option<String> get uuid;
  @override
  String get description;
  @override
  O.Option<String> get code;
  @override
  VoucherCodeType get codeType;
  @override
  O.Option<DateTime> get expires;
  @override
  bool get removeOnceExpired;
  @override
  O.Option<double> get balance;
  @override
  O.Option<int> get balanceMilliunits;
  @override
  String get notes;
  @override
  VoucherColor get color;
  @override
  @JsonKey(ignore: true)
  _$$_VoucherCopyWith<_$_Voucher> get copyWith =>
      throw _privateConstructorUsedError;
}
