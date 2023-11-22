// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return _Friend.fromJson(json);
}

/// @nodoc
mixin _$Friend {
  @IntegerConverter()
  int get it => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  @IntegerConverter()
  @JsonKey(name: "same_friends")
  int get sameFriends => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get created => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FriendCopyWith<Friend> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendCopyWith<$Res> {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) then) =
      _$FriendCopyWithImpl<$Res, Friend>;
  @useResult
  $Res call(
      {@IntegerConverter() int it,
      String username,
      String avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") int sameFriends,
      @DateTimeConverter() DateTime created});
}

/// @nodoc
class _$FriendCopyWithImpl<$Res, $Val extends Friend>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? it = null,
    Object? username = null,
    Object? avatar = null,
    Object? sameFriends = null,
    Object? created = null,
  }) {
    return _then(_value.copyWith(
      it: null == it
          ? _value.it
          : it // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      sameFriends: null == sameFriends
          ? _value.sameFriends
          : sameFriends // ignore: cast_nullable_to_non_nullable
              as int,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendImplCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$$FriendImplCopyWith(
          _$FriendImpl value, $Res Function(_$FriendImpl) then) =
      __$$FriendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntegerConverter() int it,
      String username,
      String avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") int sameFriends,
      @DateTimeConverter() DateTime created});
}

/// @nodoc
class __$$FriendImplCopyWithImpl<$Res>
    extends _$FriendCopyWithImpl<$Res, _$FriendImpl>
    implements _$$FriendImplCopyWith<$Res> {
  __$$FriendImplCopyWithImpl(
      _$FriendImpl _value, $Res Function(_$FriendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? it = null,
    Object? username = null,
    Object? avatar = null,
    Object? sameFriends = null,
    Object? created = null,
  }) {
    return _then(_$FriendImpl(
      null == it
          ? _value.it
          : it // ignore: cast_nullable_to_non_nullable
              as int,
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      null == sameFriends
          ? _value.sameFriends
          : sameFriends // ignore: cast_nullable_to_non_nullable
              as int,
      null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$FriendImpl implements _Friend {
  const _$FriendImpl(
      @IntegerConverter() this.it,
      this.username,
      this.avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") this.sameFriends,
      @DateTimeConverter() this.created);

  factory _$FriendImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendImplFromJson(json);

  @override
  @IntegerConverter()
  final int it;
  @override
  final String username;
  @override
  final String avatar;
  @override
  @IntegerConverter()
  @JsonKey(name: "same_friends")
  final int sameFriends;
  @override
  @DateTimeConverter()
  final DateTime created;

  @override
  String toString() {
    return 'Friend(it: $it, username: $username, avatar: $avatar, sameFriends: $sameFriends, created: $created)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendImpl &&
            (identical(other.it, it) || other.it == it) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.sameFriends, sameFriends) ||
                other.sameFriends == sameFriends) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, it, username, avatar, sameFriends, created);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      __$$FriendImplCopyWithImpl<_$FriendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendImplToJson(
      this,
    );
  }
}

abstract class _Friend implements Friend {
  const factory _Friend(
      @IntegerConverter() final int it,
      final String username,
      final String avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") final int sameFriends,
      @DateTimeConverter() final DateTime created) = _$FriendImpl;

  factory _Friend.fromJson(Map<String, dynamic> json) = _$FriendImpl.fromJson;

  @override
  @IntegerConverter()
  int get it;
  @override
  String get username;
  @override
  String get avatar;
  @override
  @IntegerConverter()
  @JsonKey(name: "same_friends")
  int get sameFriends;
  @override
  @DateTimeConverter()
  DateTime get created;
  @override
  @JsonKey(ignore: true)
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
