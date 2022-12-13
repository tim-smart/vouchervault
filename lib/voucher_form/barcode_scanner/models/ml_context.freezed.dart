// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ml_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MlContext {
  TextRecognizer get textRecognizer => throw _privateConstructorUsedError;
  BarcodeScanner get barcodeScanner => throw _privateConstructorUsedError;
  EntityExtractor get entityExtractor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MlContextCopyWith<MlContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MlContextCopyWith<$Res> {
  factory $MlContextCopyWith(MlContext value, $Res Function(MlContext) then) =
      _$MlContextCopyWithImpl<$Res, MlContext>;
  @useResult
  $Res call(
      {TextRecognizer textRecognizer,
      BarcodeScanner barcodeScanner,
      EntityExtractor entityExtractor});
}

/// @nodoc
class _$MlContextCopyWithImpl<$Res, $Val extends MlContext>
    implements $MlContextCopyWith<$Res> {
  _$MlContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textRecognizer = null,
    Object? barcodeScanner = null,
    Object? entityExtractor = null,
  }) {
    return _then(_value.copyWith(
      textRecognizer: null == textRecognizer
          ? _value.textRecognizer
          : textRecognizer // ignore: cast_nullable_to_non_nullable
              as TextRecognizer,
      barcodeScanner: null == barcodeScanner
          ? _value.barcodeScanner
          : barcodeScanner // ignore: cast_nullable_to_non_nullable
              as BarcodeScanner,
      entityExtractor: null == entityExtractor
          ? _value.entityExtractor
          : entityExtractor // ignore: cast_nullable_to_non_nullable
              as EntityExtractor,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MlContextCopyWith<$Res> implements $MlContextCopyWith<$Res> {
  factory _$$_MlContextCopyWith(
          _$_MlContext value, $Res Function(_$_MlContext) then) =
      __$$_MlContextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextRecognizer textRecognizer,
      BarcodeScanner barcodeScanner,
      EntityExtractor entityExtractor});
}

/// @nodoc
class __$$_MlContextCopyWithImpl<$Res>
    extends _$MlContextCopyWithImpl<$Res, _$_MlContext>
    implements _$$_MlContextCopyWith<$Res> {
  __$$_MlContextCopyWithImpl(
      _$_MlContext _value, $Res Function(_$_MlContext) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textRecognizer = null,
    Object? barcodeScanner = null,
    Object? entityExtractor = null,
  }) {
    return _then(_$_MlContext(
      textRecognizer: null == textRecognizer
          ? _value.textRecognizer
          : textRecognizer // ignore: cast_nullable_to_non_nullable
              as TextRecognizer,
      barcodeScanner: null == barcodeScanner
          ? _value.barcodeScanner
          : barcodeScanner // ignore: cast_nullable_to_non_nullable
              as BarcodeScanner,
      entityExtractor: null == entityExtractor
          ? _value.entityExtractor
          : entityExtractor // ignore: cast_nullable_to_non_nullable
              as EntityExtractor,
    ));
  }
}

/// @nodoc

class _$_MlContext implements _MlContext {
  const _$_MlContext(
      {required this.textRecognizer,
      required this.barcodeScanner,
      required this.entityExtractor});

  @override
  final TextRecognizer textRecognizer;
  @override
  final BarcodeScanner barcodeScanner;
  @override
  final EntityExtractor entityExtractor;

  @override
  String toString() {
    return 'MlContext(textRecognizer: $textRecognizer, barcodeScanner: $barcodeScanner, entityExtractor: $entityExtractor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MlContext &&
            (identical(other.textRecognizer, textRecognizer) ||
                other.textRecognizer == textRecognizer) &&
            (identical(other.barcodeScanner, barcodeScanner) ||
                other.barcodeScanner == barcodeScanner) &&
            (identical(other.entityExtractor, entityExtractor) ||
                other.entityExtractor == entityExtractor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textRecognizer, barcodeScanner, entityExtractor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MlContextCopyWith<_$_MlContext> get copyWith =>
      __$$_MlContextCopyWithImpl<_$_MlContext>(this, _$identity);
}

abstract class _MlContext implements MlContext {
  const factory _MlContext(
      {required final TextRecognizer textRecognizer,
      required final BarcodeScanner barcodeScanner,
      required final EntityExtractor entityExtractor}) = _$_MlContext;

  @override
  TextRecognizer get textRecognizer;
  @override
  BarcodeScanner get barcodeScanner;
  @override
  EntityExtractor get entityExtractor;
  @override
  @JsonKey(ignore: true)
  _$$_MlContextCopyWith<_$_MlContext> get copyWith =>
      throw _privateConstructorUsedError;
}
