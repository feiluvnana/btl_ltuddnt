// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FriendState {
  List<Friend>? get suggestedFriends => throw _privateConstructorUsedError;
  List<Friend>? get requestedFriends => throw _privateConstructorUsedError;
  List<Friend>? get allFriends => throw _privateConstructorUsedError;
  int get totalAll => throw _privateConstructorUsedError;
  int get totalRequested => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FriendStateCopyWith<FriendState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendStateCopyWith<$Res> {
  factory $FriendStateCopyWith(
          FriendState value, $Res Function(FriendState) then) =
      _$FriendStateCopyWithImpl<$Res, FriendState>;
  @useResult
  $Res call(
      {List<Friend>? suggestedFriends,
      List<Friend>? requestedFriends,
      List<Friend>? allFriends,
      int totalAll,
      int totalRequested});
}

/// @nodoc
class _$FriendStateCopyWithImpl<$Res, $Val extends FriendState>
    implements $FriendStateCopyWith<$Res> {
  _$FriendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedFriends = freezed,
    Object? requestedFriends = freezed,
    Object? allFriends = freezed,
    Object? totalAll = null,
    Object? totalRequested = null,
  }) {
    return _then(_value.copyWith(
      suggestedFriends: freezed == suggestedFriends
          ? _value.suggestedFriends
          : suggestedFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      requestedFriends: freezed == requestedFriends
          ? _value.requestedFriends
          : requestedFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      allFriends: freezed == allFriends
          ? _value.allFriends
          : allFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      totalAll: null == totalAll
          ? _value.totalAll
          : totalAll // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendStateImplCopyWith<$Res>
    implements $FriendStateCopyWith<$Res> {
  factory _$$FriendStateImplCopyWith(
          _$FriendStateImpl value, $Res Function(_$FriendStateImpl) then) =
      __$$FriendStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Friend>? suggestedFriends,
      List<Friend>? requestedFriends,
      List<Friend>? allFriends,
      int totalAll,
      int totalRequested});
}

/// @nodoc
class __$$FriendStateImplCopyWithImpl<$Res>
    extends _$FriendStateCopyWithImpl<$Res, _$FriendStateImpl>
    implements _$$FriendStateImplCopyWith<$Res> {
  __$$FriendStateImplCopyWithImpl(
      _$FriendStateImpl _value, $Res Function(_$FriendStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedFriends = freezed,
    Object? requestedFriends = freezed,
    Object? allFriends = freezed,
    Object? totalAll = null,
    Object? totalRequested = null,
  }) {
    return _then(_$FriendStateImpl(
      suggestedFriends: freezed == suggestedFriends
          ? _value._suggestedFriends
          : suggestedFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      requestedFriends: freezed == requestedFriends
          ? _value._requestedFriends
          : requestedFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      allFriends: freezed == allFriends
          ? _value._allFriends
          : allFriends // ignore: cast_nullable_to_non_nullable
              as List<Friend>?,
      totalAll: null == totalAll
          ? _value.totalAll
          : totalAll // ignore: cast_nullable_to_non_nullable
              as int,
      totalRequested: null == totalRequested
          ? _value.totalRequested
          : totalRequested // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FriendStateImpl implements _FriendState {
  const _$FriendStateImpl(
      {final List<Friend>? suggestedFriends,
      final List<Friend>? requestedFriends,
      final List<Friend>? allFriends,
      this.totalAll = 0,
      this.totalRequested = 0})
      : _suggestedFriends = suggestedFriends,
        _requestedFriends = requestedFriends,
        _allFriends = allFriends;

  final List<Friend>? _suggestedFriends;
  @override
  List<Friend>? get suggestedFriends {
    final value = _suggestedFriends;
    if (value == null) return null;
    if (_suggestedFriends is EqualUnmodifiableListView)
      return _suggestedFriends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Friend>? _requestedFriends;
  @override
  List<Friend>? get requestedFriends {
    final value = _requestedFriends;
    if (value == null) return null;
    if (_requestedFriends is EqualUnmodifiableListView)
      return _requestedFriends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Friend>? _allFriends;
  @override
  List<Friend>? get allFriends {
    final value = _allFriends;
    if (value == null) return null;
    if (_allFriends is EqualUnmodifiableListView) return _allFriends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int totalAll;
  @override
  @JsonKey()
  final int totalRequested;

  @override
  String toString() {
    return 'FriendState(suggestedFriends: $suggestedFriends, requestedFriends: $requestedFriends, allFriends: $allFriends, totalAll: $totalAll, totalRequested: $totalRequested)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendStateImpl &&
            const DeepCollectionEquality()
                .equals(other._suggestedFriends, _suggestedFriends) &&
            const DeepCollectionEquality()
                .equals(other._requestedFriends, _requestedFriends) &&
            const DeepCollectionEquality()
                .equals(other._allFriends, _allFriends) &&
            (identical(other.totalAll, totalAll) ||
                other.totalAll == totalAll) &&
            (identical(other.totalRequested, totalRequested) ||
                other.totalRequested == totalRequested));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_suggestedFriends),
      const DeepCollectionEquality().hash(_requestedFriends),
      const DeepCollectionEquality().hash(_allFriends),
      totalAll,
      totalRequested);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendStateImplCopyWith<_$FriendStateImpl> get copyWith =>
      __$$FriendStateImplCopyWithImpl<_$FriendStateImpl>(this, _$identity);
}

abstract class _FriendState implements FriendState {
  const factory _FriendState(
      {final List<Friend>? suggestedFriends,
      final List<Friend>? requestedFriends,
      final List<Friend>? allFriends,
      final int totalAll,
      final int totalRequested}) = _$FriendStateImpl;

  @override
  List<Friend>? get suggestedFriends;
  @override
  List<Friend>? get requestedFriends;
  @override
  List<Friend>? get allFriends;
  @override
  int get totalAll;
  @override
  int get totalRequested;
  @override
  @JsonKey(ignore: true)
  _$$FriendStateImplCopyWith<_$FriendStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
