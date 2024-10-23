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
mixin _$QrCodeListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<QrCodeGenerate> get codes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QrCodeListStateCopyWith<QrCodeListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCodeListStateCopyWith<$Res> {
  factory $QrCodeListStateCopyWith(
          QrCodeListState value, $Res Function(QrCodeListState) then) =
      _$QrCodeListStateCopyWithImpl<$Res, QrCodeListState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      List<QrCodeGenerate> codes});
}

/// @nodoc
class _$QrCodeListStateCopyWithImpl<$Res, $Val extends QrCodeListState>
    implements $QrCodeListStateCopyWith<$Res> {
  _$QrCodeListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? codes = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      codes: null == codes
          ? _value.codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<QrCodeGenerate>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrCodeListStateImplCopyWith<$Res>
    implements $QrCodeListStateCopyWith<$Res> {
  factory _$$QrCodeListStateImplCopyWith(_$QrCodeListStateImpl value,
          $Res Function(_$QrCodeListStateImpl) then) =
      __$$QrCodeListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      List<QrCodeGenerate> codes});
}

/// @nodoc
class __$$QrCodeListStateImplCopyWithImpl<$Res>
    extends _$QrCodeListStateCopyWithImpl<$Res, _$QrCodeListStateImpl>
    implements _$$QrCodeListStateImplCopyWith<$Res> {
  __$$QrCodeListStateImplCopyWithImpl(
      _$QrCodeListStateImpl _value, $Res Function(_$QrCodeListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? codes = null,
  }) {
    return _then(_$QrCodeListStateImpl(
      null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      null == codes
          ? _value._codes
          : codes // ignore: cast_nullable_to_non_nullable
              as List<QrCodeGenerate>,
    ));
  }
}

/// @nodoc

class _$QrCodeListStateImpl implements _QrCodeListState {
  _$QrCodeListStateImpl(
      [this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      final List<QrCodeGenerate> codes = const []])
      : _codes = codes;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String errorMessage;
  final List<QrCodeGenerate> _codes;
  @override
  @JsonKey()
  List<QrCodeGenerate> get codes {
    if (_codes is EqualUnmodifiableListView) return _codes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codes);
  }

  @override
  String toString() {
    return 'QrCodeListState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, codes: $codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrCodeListStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._codes, _codes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isError, errorMessage,
      const DeepCollectionEquality().hash(_codes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QrCodeListStateImplCopyWith<_$QrCodeListStateImpl> get copyWith =>
      __$$QrCodeListStateImplCopyWithImpl<_$QrCodeListStateImpl>(
          this, _$identity);
}

abstract class _QrCodeListState implements QrCodeListState {
  factory _QrCodeListState(
      [final bool isLoading,
      final bool isError,
      final String errorMessage,
      final List<QrCodeGenerate> codes]) = _$QrCodeListStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  List<QrCodeGenerate> get codes;
  @override
  @JsonKey(ignore: true)
  _$$QrCodeListStateImplCopyWith<_$QrCodeListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QrCodeState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  QrCodeGenerate? get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QrCodeStateCopyWith<QrCodeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCodeStateCopyWith<$Res> {
  factory $QrCodeStateCopyWith(
          QrCodeState value, $Res Function(QrCodeState) then) =
      _$QrCodeStateCopyWithImpl<$Res, QrCodeState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      QrCodeGenerate? code});
}

/// @nodoc
class _$QrCodeStateCopyWithImpl<$Res, $Val extends QrCodeState>
    implements $QrCodeStateCopyWith<$Res> {
  _$QrCodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as QrCodeGenerate?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrCodeStateImplCopyWith<$Res>
    implements $QrCodeStateCopyWith<$Res> {
  factory _$$QrCodeStateImplCopyWith(
          _$QrCodeStateImpl value, $Res Function(_$QrCodeStateImpl) then) =
      __$$QrCodeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      QrCodeGenerate? code});
}

/// @nodoc
class __$$QrCodeStateImplCopyWithImpl<$Res>
    extends _$QrCodeStateCopyWithImpl<$Res, _$QrCodeStateImpl>
    implements _$$QrCodeStateImplCopyWith<$Res> {
  __$$QrCodeStateImplCopyWithImpl(
      _$QrCodeStateImpl _value, $Res Function(_$QrCodeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? code = freezed,
  }) {
    return _then(_$QrCodeStateImpl(
      null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as QrCodeGenerate?,
    ));
  }
}

/// @nodoc

class _$QrCodeStateImpl implements _QrCodeState {
  _$QrCodeStateImpl(
      [this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      this.code]);

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final QrCodeGenerate? code;

  @override
  String toString() {
    return 'QrCodeState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrCodeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, isError, errorMessage, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QrCodeStateImplCopyWith<_$QrCodeStateImpl> get copyWith =>
      __$$QrCodeStateImplCopyWithImpl<_$QrCodeStateImpl>(this, _$identity);
}

abstract class _QrCodeState implements QrCodeState {
  factory _QrCodeState(
      [final bool isLoading,
      final bool isError,
      final String errorMessage,
      final QrCodeGenerate? code]) = _$QrCodeStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  QrCodeGenerate? get code;
  @override
  @JsonKey(ignore: true)
  _$$QrCodeStateImplCopyWith<_$QrCodeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
