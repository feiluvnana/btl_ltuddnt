// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authen.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthenState {
  Map<String, String> get signupInfo => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenStateCopyWith<AuthenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenStateCopyWith<$Res> {
  factory $AuthenStateCopyWith(
          AuthenState value, $Res Function(AuthenState) then) =
      _$AuthenStateCopyWithImpl<$Res, AuthenState>;
  @useResult
  $Res call({Map<String, String> signupInfo, User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthenStateCopyWithImpl<$Res, $Val extends AuthenState>
    implements $AuthenStateCopyWith<$Res> {
  _$AuthenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signupInfo = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      signupInfo: null == signupInfo
          ? _value.signupInfo
          : signupInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenStateImplCopyWith<$Res>
    implements $AuthenStateCopyWith<$Res> {
  factory _$$AuthenStateImplCopyWith(
          _$AuthenStateImpl value, $Res Function(_$AuthenStateImpl) then) =
      __$$AuthenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> signupInfo, User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuthenStateImplCopyWithImpl<$Res>
    extends _$AuthenStateCopyWithImpl<$Res, _$AuthenStateImpl>
    implements _$$AuthenStateImplCopyWith<$Res> {
  __$$AuthenStateImplCopyWithImpl(
      _$AuthenStateImpl _value, $Res Function(_$AuthenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signupInfo = null,
    Object? user = freezed,
  }) {
    return _then(_$AuthenStateImpl(
      signupInfo: null == signupInfo
          ? _value._signupInfo
          : signupInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$AuthenStateImpl implements _AuthenState {
  const _$AuthenStateImpl(
      {final Map<String, String> signupInfo = const {}, this.user})
      : _signupInfo = signupInfo;

  final Map<String, String> _signupInfo;
  @override
  @JsonKey()
  Map<String, String> get signupInfo {
    if (_signupInfo is EqualUnmodifiableMapView) return _signupInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_signupInfo);
  }

  @override
  final User? user;

  @override
  String toString() {
    return 'AuthenState(signupInfo: $signupInfo, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._signupInfo, _signupInfo) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signupInfo), user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenStateImplCopyWith<_$AuthenStateImpl> get copyWith =>
      __$$AuthenStateImplCopyWithImpl<_$AuthenStateImpl>(this, _$identity);
}

abstract class _AuthenState implements AuthenState {
  const factory _AuthenState(
      {final Map<String, String> signupInfo,
      final User? user}) = _$AuthenStateImpl;

  @override
  Map<String, String> get signupInfo;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$AuthenStateImplCopyWith<_$AuthenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
