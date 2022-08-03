// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VouchersState {
  IList<Voucher> get vouchers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VouchersStateCopyWith<VouchersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VouchersStateCopyWith<$Res> {
  factory $VouchersStateCopyWith(
          VouchersState value, $Res Function(VouchersState) then) =
      _$VouchersStateCopyWithImpl<$Res>;
  $Res call({IList<Voucher> vouchers});
}

/// @nodoc
class _$VouchersStateCopyWithImpl<$Res>
    implements $VouchersStateCopyWith<$Res> {
  _$VouchersStateCopyWithImpl(this._value, this._then);

  final VouchersState _value;
  // ignore: unused_field
  final $Res Function(VouchersState) _then;

  @override
  $Res call({
    Object? vouchers = freezed,
  }) {
    return _then(_value.copyWith(
      vouchers: vouchers == freezed
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as IList<Voucher>,
    ));
  }
}

/// @nodoc
abstract class _$$_VouchersStateCopyWith<$Res>
    implements $VouchersStateCopyWith<$Res> {
  factory _$$_VouchersStateCopyWith(
          _$_VouchersState value, $Res Function(_$_VouchersState) then) =
      __$$_VouchersStateCopyWithImpl<$Res>;
  @override
  $Res call({IList<Voucher> vouchers});
}

/// @nodoc
class __$$_VouchersStateCopyWithImpl<$Res>
    extends _$VouchersStateCopyWithImpl<$Res>
    implements _$$_VouchersStateCopyWith<$Res> {
  __$$_VouchersStateCopyWithImpl(
      _$_VouchersState _value, $Res Function(_$_VouchersState) _then)
      : super(_value, (v) => _then(v as _$_VouchersState));

  @override
  _$_VouchersState get _value => super._value as _$_VouchersState;

  @override
  $Res call({
    Object? vouchers = freezed,
  }) {
    return _then(_$_VouchersState(
      vouchers == freezed
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as IList<Voucher>,
    ));
  }
}

/// @nodoc

class _$_VouchersState extends _VouchersState {
  _$_VouchersState(this.vouchers) : super._();

  @override
  final IList<Voucher> vouchers;

  @override
  String toString() {
    return 'VouchersState(vouchers: $vouchers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VouchersState &&
            const DeepCollectionEquality().equals(other.vouchers, vouchers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(vouchers));

  @JsonKey(ignore: true)
  @override
  _$$_VouchersStateCopyWith<_$_VouchersState> get copyWith =>
      __$$_VouchersStateCopyWithImpl<_$_VouchersState>(this, _$identity);
}

abstract class _VouchersState extends VouchersState {
  factory _VouchersState(final IList<Voucher> vouchers) = _$_VouchersState;
  _VouchersState._() : super._();

  @override
  IList<Voucher> get vouchers;
  @override
  @JsonKey(ignore: true)
  _$$_VouchersStateCopyWith<_$_VouchersState> get copyWith =>
      throw _privateConstructorUsedError;
}
