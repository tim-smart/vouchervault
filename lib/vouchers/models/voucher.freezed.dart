// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return _Voucher.fromJson(json);
}

/// @nodoc
mixin _$Voucher {
  Option<String> get uuid => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Option<String> get code => throw _privateConstructorUsedError;
  VoucherCodeType get codeType => throw _privateConstructorUsedError;
  Option<DateTime> get expires => throw _privateConstructorUsedError;
  bool get removeOnceExpired => throw _privateConstructorUsedError;
  Option<double> get balance => throw _privateConstructorUsedError;
  Option<int> get balanceMilliunits => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  VoucherColor get color => throw _privateConstructorUsedError;

  /// Serializes this Voucher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherCopyWith<Voucher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherCopyWith<$Res> {
  factory $VoucherCopyWith(Voucher value, $Res Function(Voucher) then) =
      _$VoucherCopyWithImpl<$Res, Voucher>;
  @useResult
  $Res call(
      {Option<String> uuid,
      String description,
      Option<String> code,
      VoucherCodeType codeType,
      Option<DateTime> expires,
      bool removeOnceExpired,
      Option<double> balance,
      Option<int> balanceMilliunits,
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

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
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
              as Option<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      codeType: null == codeType
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as Option<DateTime>,
      removeOnceExpired: null == removeOnceExpired
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Option<double>,
      balanceMilliunits: null == balanceMilliunits
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as Option<int>,
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
abstract class _$$VoucherImplCopyWith<$Res> implements $VoucherCopyWith<$Res> {
  factory _$$VoucherImplCopyWith(
          _$VoucherImpl value, $Res Function(_$VoucherImpl) then) =
      __$$VoucherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Option<String> uuid,
      String description,
      Option<String> code,
      VoucherCodeType codeType,
      Option<DateTime> expires,
      bool removeOnceExpired,
      Option<double> balance,
      Option<int> balanceMilliunits,
      String notes,
      VoucherColor color});
}

/// @nodoc
class __$$VoucherImplCopyWithImpl<$Res>
    extends _$VoucherCopyWithImpl<$Res, _$VoucherImpl>
    implements _$$VoucherImplCopyWith<$Res> {
  __$$VoucherImplCopyWithImpl(
      _$VoucherImpl _value, $Res Function(_$VoucherImpl) _then)
      : super(_value, _then);

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_$VoucherImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      codeType: null == codeType
          ? _value.codeType
          : codeType // ignore: cast_nullable_to_non_nullable
              as VoucherCodeType,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as Option<DateTime>,
      removeOnceExpired: null == removeOnceExpired
          ? _value.removeOnceExpired
          : removeOnceExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Option<double>,
      balanceMilliunits: null == balanceMilliunits
          ? _value.balanceMilliunits
          : balanceMilliunits // ignore: cast_nullable_to_non_nullable
              as Option<int>,
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
class _$VoucherImpl extends _Voucher {
  _$VoucherImpl(
      {this.uuid = const Option.none(),
      this.description = '',
      this.code = const Option.none(),
      this.codeType = VoucherCodeType.CODE128,
      this.expires = const Option.none(),
      this.removeOnceExpired = true,
      this.balance = const Option.none(),
      this.balanceMilliunits = const Option.none(),
      this.notes = '',
      this.color = VoucherColor.GREY})
      : super._();

  factory _$VoucherImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherImplFromJson(json);

  @override
  @JsonKey()
  final Option<String> uuid;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final Option<String> code;
  @override
  @JsonKey()
  final VoucherCodeType codeType;
  @override
  @JsonKey()
  final Option<DateTime> expires;
  @override
  @JsonKey()
  final bool removeOnceExpired;
  @override
  @JsonKey()
  final Option<double> balance;
  @override
  @JsonKey()
  final Option<int> balanceMilliunits;
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      __$$VoucherImplCopyWithImpl<_$VoucherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherImplToJson(
      this,
    );
  }
}

abstract class _Voucher extends Voucher {
  factory _Voucher(
      {final Option<String> uuid,
      final String description,
      final Option<String> code,
      final VoucherCodeType codeType,
      final Option<DateTime> expires,
      final bool removeOnceExpired,
      final Option<double> balance,
      final Option<int> balanceMilliunits,
      final String notes,
      final VoucherColor color}) = _$VoucherImpl;
  _Voucher._() : super._();

  factory _Voucher.fromJson(Map<String, dynamic> json) = _$VoucherImpl.fromJson;

  @override
  Option<String> get uuid;
  @override
  String get description;
  @override
  Option<String> get code;
  @override
  VoucherCodeType get codeType;
  @override
  Option<DateTime> get expires;
  @override
  bool get removeOnceExpired;
  @override
  Option<double> get balance;
  @override
  Option<int> get balanceMilliunits;
  @override
  String get notes;
  @override
  VoucherColor get color;

  /// Create a copy of Voucher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherImplCopyWith<_$VoucherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
