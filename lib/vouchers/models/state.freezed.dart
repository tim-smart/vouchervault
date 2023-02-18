// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$VouchersStateCopyWithImpl<$Res, VouchersState>;
  @useResult
  $Res call({IList<Voucher> vouchers});
}

/// @nodoc
class _$VouchersStateCopyWithImpl<$Res, $Val extends VouchersState>
    implements $VouchersStateCopyWith<$Res> {
  _$VouchersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vouchers = null,
  }) {
    return _then(_value.copyWith(
      vouchers: null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as IList<Voucher>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VouchersStateCopyWith<$Res>
    implements $VouchersStateCopyWith<$Res> {
  factory _$$_VouchersStateCopyWith(
          _$_VouchersState value, $Res Function(_$_VouchersState) then) =
      __$$_VouchersStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Voucher> vouchers});
}

/// @nodoc
class __$$_VouchersStateCopyWithImpl<$Res>
    extends _$VouchersStateCopyWithImpl<$Res, _$_VouchersState>
    implements _$$_VouchersStateCopyWith<$Res> {
  __$$_VouchersStateCopyWithImpl(
      _$_VouchersState _value, $Res Function(_$_VouchersState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vouchers = null,
  }) {
    return _then(_$_VouchersState(
      null == vouchers
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
  @pragma('vm:prefer-inline')
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
