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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BarcodeResult {
  Barcode get barcode => throw _privateConstructorUsedError;
  Option<String> get merchant => throw _privateConstructorUsedError;
  Option<int> get balance => throw _privateConstructorUsedError;
  Option<DateTime> get expires => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
abstract class _$$_BarcodeResultCopyWith<$Res>
    implements $BarcodeResultCopyWith<$Res> {
  factory _$$_BarcodeResultCopyWith(
          _$_BarcodeResult value, $Res Function(_$_BarcodeResult) then) =
      __$$_BarcodeResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Barcode barcode,
      Option<String> merchant,
      Option<int> balance,
      Option<DateTime> expires});
}

/// @nodoc
class __$$_BarcodeResultCopyWithImpl<$Res>
    extends _$BarcodeResultCopyWithImpl<$Res, _$_BarcodeResult>
    implements _$$_BarcodeResultCopyWith<$Res> {
  __$$_BarcodeResultCopyWithImpl(
      _$_BarcodeResult _value, $Res Function(_$_BarcodeResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = null,
    Object? merchant = null,
    Object? balance = null,
    Object? expires = null,
  }) {
    return _then(_$_BarcodeResult(
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

class _$_BarcodeResult implements _BarcodeResult {
  const _$_BarcodeResult(
      {required this.barcode,
      this.merchant = const None(),
      this.balance = const None(),
      this.expires = const None()});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BarcodeResult &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.expires, expires) || other.expires == expires));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, barcode, merchant, balance, expires);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BarcodeResultCopyWith<_$_BarcodeResult> get copyWith =>
      __$$_BarcodeResultCopyWithImpl<_$_BarcodeResult>(this, _$identity);
}

abstract class _BarcodeResult implements BarcodeResult {
  const factory _BarcodeResult(
      {required final Barcode barcode,
      final Option<String> merchant,
      final Option<int> balance,
      final Option<DateTime> expires}) = _$_BarcodeResult;

  @override
  Barcode get barcode;
  @override
  Option<String> get merchant;
  @override
  Option<int> get balance;
  @override
  Option<DateTime> get expires;
  @override
  @JsonKey(ignore: true)
  _$$_BarcodeResultCopyWith<_$_BarcodeResult> get copyWith =>
      throw _privateConstructorUsedError;
}
