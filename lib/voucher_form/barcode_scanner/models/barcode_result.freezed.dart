// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barcode_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BarcodeResult {
  Barcode get barcode => throw _privateConstructorUsedError;
  Option<String> get merchant => throw _privateConstructorUsedError;
  Option<int> get balance => throw _privateConstructorUsedError;
  Option<DateTime> get expires => throw _privateConstructorUsedError;

  /// Create a copy of BarcodeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarcodeResultCopyWith<BarcodeResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeResultCopyWith<$Res> {
  factory $BarcodeResultCopyWith(
          BarcodeResult value, $Res Function(BarcodeResult) then) =
      _$BarcodeResultCopyWithImpl<$Res, BarcodeResult>;
  @useResult
  $Res call(
      {Barcode barcode,
      Option<String> merchant,
      Option<int> balance,
      Option<DateTime> expires});
}

/// @nodoc
class _$BarcodeResultCopyWithImpl<$Res, $Val extends BarcodeResult>
    implements $BarcodeResultCopyWith<$Res> {
  _$BarcodeResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarcodeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
    Object? merchant = null,
    Object? balance = null,
    Object? expires = null,
  }) {
    return _then(_value.copyWith(
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Option<int>,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as Option<DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarcodeResultImplCopyWith<$Res>
    implements $BarcodeResultCopyWith<$Res> {
  factory _$$BarcodeResultImplCopyWith(
          _$BarcodeResultImpl value, $Res Function(_$BarcodeResultImpl) then) =
      __$$BarcodeResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Barcode barcode,
      Option<String> merchant,
      Option<int> balance,
      Option<DateTime> expires});
}

/// @nodoc
class __$$BarcodeResultImplCopyWithImpl<$Res>
    extends _$BarcodeResultCopyWithImpl<$Res, _$BarcodeResultImpl>
    implements _$$BarcodeResultImplCopyWith<$Res> {
  __$$BarcodeResultImplCopyWithImpl(
      _$BarcodeResultImpl _value, $Res Function(_$BarcodeResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of BarcodeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
    Object? merchant = null,
    Object? balance = null,
    Object? expires = null,
  }) {
    return _then(_$BarcodeResultImpl(
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as Barcode,
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Option<int>,
      expires: null == expires
          ? _value.expires
          : expires // ignore: cast_nullable_to_non_nullable
              as Option<DateTime>,
    ));
  }
}

/// @nodoc

class _$BarcodeResultImpl implements _BarcodeResult {
  const _$BarcodeResultImpl(
      {required this.barcode,
      this.merchant = const Option.none(),
      this.balance = const Option.none(),
      this.expires = const Option.none()});

  @override
  final Barcode barcode;
  @override
  @JsonKey()
  final Option<String> merchant;
  @override
  @JsonKey()
  final Option<int> balance;
  @override
  @JsonKey()
  final Option<DateTime> expires;

  @override
  String toString() {
    return 'BarcodeResult(barcode: $barcode, merchant: $merchant, balance: $balance, expires: $expires)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeResultImpl &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.expires, expires) || other.expires == expires));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, barcode, merchant, balance, expires);

  /// Create a copy of BarcodeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeResultImplCopyWith<_$BarcodeResultImpl> get copyWith =>
      __$$BarcodeResultImplCopyWithImpl<_$BarcodeResultImpl>(this, _$identity);
}

abstract class _BarcodeResult implements BarcodeResult {
  const factory _BarcodeResult(
      {required final Barcode barcode,
      final Option<String> merchant,
      final Option<int> balance,
      final Option<DateTime> expires}) = _$BarcodeResultImpl;

  @override
  Barcode get barcode;
  @override
  Option<String> get merchant;
  @override
  Option<int> get balance;
  @override
  Option<DateTime> get expires;

  /// Create a copy of BarcodeResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarcodeResultImplCopyWith<_$BarcodeResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
