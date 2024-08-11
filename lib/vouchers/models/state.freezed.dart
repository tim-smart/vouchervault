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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VouchersState {
  IList<Voucher> get vouchers => throw _privateConstructorUsedError;

  /// Create a copy of VouchersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of VouchersState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$VouchersStateImplCopyWith<$Res>
    implements $VouchersStateCopyWith<$Res> {
  factory _$$VouchersStateImplCopyWith(
          _$VouchersStateImpl value, $Res Function(_$VouchersStateImpl) then) =
      __$$VouchersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IList<Voucher> vouchers});
}

/// @nodoc
class __$$VouchersStateImplCopyWithImpl<$Res>
    extends _$VouchersStateCopyWithImpl<$Res, _$VouchersStateImpl>
    implements _$$VouchersStateImplCopyWith<$Res> {
  __$$VouchersStateImplCopyWithImpl(
      _$VouchersStateImpl _value, $Res Function(_$VouchersStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VouchersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vouchers = null,
  }) {
    return _then(_$VouchersStateImpl(
      null == vouchers
          ? _value.vouchers
          : vouchers // ignore: cast_nullable_to_non_nullable
              as IList<Voucher>,
    ));
  }
}

/// @nodoc

class _$VouchersStateImpl extends _VouchersState {
  _$VouchersStateImpl(this.vouchers) : super._();

  @override
  final IList<Voucher> vouchers;

  @override
  String toString() {
    return 'VouchersState(vouchers: $vouchers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VouchersStateImpl &&
            const DeepCollectionEquality().equals(other.vouchers, vouchers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(vouchers));

  /// Create a copy of VouchersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VouchersStateImplCopyWith<_$VouchersStateImpl> get copyWith =>
      __$$VouchersStateImplCopyWithImpl<_$VouchersStateImpl>(this, _$identity);
}

abstract class _VouchersState extends VouchersState {
  factory _VouchersState(final IList<Voucher> vouchers) = _$VouchersStateImpl;
  _VouchersState._() : super._();

  @override
  IList<Voucher> get vouchers;

  /// Create a copy of VouchersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VouchersStateImplCopyWith<_$VouchersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
