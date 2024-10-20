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
mixin _$LocalCodeListState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<LocalBarcode> get codes => throw _privateConstructorUsedError;

  /// Create a copy of LocalCodeListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalCodeListStateCopyWith<LocalCodeListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalCodeListStateCopyWith<$Res> {
  factory $LocalCodeListStateCopyWith(
          LocalCodeListState value, $Res Function(LocalCodeListState) then) =
      _$LocalCodeListStateCopyWithImpl<$Res, LocalCodeListState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      List<LocalBarcode> codes});
}

/// @nodoc
class _$LocalCodeListStateCopyWithImpl<$Res, $Val extends LocalCodeListState>
    implements $LocalCodeListStateCopyWith<$Res> {
  _$LocalCodeListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalCodeListState
  /// with the given fields replaced by the non-null parameter values.
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
              as List<LocalBarcode>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalCodeListStateImplCopyWith<$Res>
    implements $LocalCodeListStateCopyWith<$Res> {
  factory _$$LocalCodeListStateImplCopyWith(_$LocalCodeListStateImpl value,
          $Res Function(_$LocalCodeListStateImpl) then) =
      __$$LocalCodeListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      List<LocalBarcode> codes});
}

/// @nodoc
class __$$LocalCodeListStateImplCopyWithImpl<$Res>
    extends _$LocalCodeListStateCopyWithImpl<$Res, _$LocalCodeListStateImpl>
    implements _$$LocalCodeListStateImplCopyWith<$Res> {
  __$$LocalCodeListStateImplCopyWithImpl(_$LocalCodeListStateImpl _value,
      $Res Function(_$LocalCodeListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalCodeListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? codes = null,
  }) {
    return _then(_$LocalCodeListStateImpl(
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
              as List<LocalBarcode>,
    ));
  }
}

/// @nodoc

class _$LocalCodeListStateImpl implements _LocalCodeListState {
  _$LocalCodeListStateImpl(
      [this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      final List<LocalBarcode> codes = const []])
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
  final List<LocalBarcode> _codes;
  @override
  @JsonKey()
  List<LocalBarcode> get codes {
    if (_codes is EqualUnmodifiableListView) return _codes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codes);
  }

  @override
  String toString() {
    return 'LocalCodeListState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, codes: $codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalCodeListStateImpl &&
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

  /// Create a copy of LocalCodeListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalCodeListStateImplCopyWith<_$LocalCodeListStateImpl> get copyWith =>
      __$$LocalCodeListStateImplCopyWithImpl<_$LocalCodeListStateImpl>(
          this, _$identity);
}

abstract class _LocalCodeListState implements LocalCodeListState {
  factory _LocalCodeListState(
      [final bool isLoading,
      final bool isError,
      final String errorMessage,
      final List<LocalBarcode> codes]) = _$LocalCodeListStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  List<LocalBarcode> get codes;

  /// Create a copy of LocalCodeListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalCodeListStateImplCopyWith<_$LocalCodeListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
