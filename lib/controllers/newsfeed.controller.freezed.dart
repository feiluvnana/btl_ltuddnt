// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newsfeed.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewsfeedState {
  List<Post>? get posts => throw _privateConstructorUsedError;
  Map<String, double> get postingProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewsfeedStateCopyWith<NewsfeedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsfeedStateCopyWith<$Res> {
  factory $NewsfeedStateCopyWith(
          NewsfeedState value, $Res Function(NewsfeedState) then) =
      _$NewsfeedStateCopyWithImpl<$Res, NewsfeedState>;
  @useResult
  $Res call({List<Post>? posts, Map<String, double> postingProgress});
}

/// @nodoc
class _$NewsfeedStateCopyWithImpl<$Res, $Val extends NewsfeedState>
    implements $NewsfeedStateCopyWith<$Res> {
  _$NewsfeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = freezed,
    Object? postingProgress = null,
  }) {
    return _then(_value.copyWith(
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>?,
      postingProgress: null == postingProgress
          ? _value.postingProgress
          : postingProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsfeedStateImplCopyWith<$Res>
    implements $NewsfeedStateCopyWith<$Res> {
  factory _$$NewsfeedStateImplCopyWith(
          _$NewsfeedStateImpl value, $Res Function(_$NewsfeedStateImpl) then) =
      __$$NewsfeedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Post>? posts, Map<String, double> postingProgress});
}

/// @nodoc
class __$$NewsfeedStateImplCopyWithImpl<$Res>
    extends _$NewsfeedStateCopyWithImpl<$Res, _$NewsfeedStateImpl>
    implements _$$NewsfeedStateImplCopyWith<$Res> {
  __$$NewsfeedStateImplCopyWithImpl(
      _$NewsfeedStateImpl _value, $Res Function(_$NewsfeedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = freezed,
    Object? postingProgress = null,
  }) {
    return _then(_$NewsfeedStateImpl(
      posts: freezed == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>?,
      postingProgress: null == postingProgress
          ? _value._postingProgress
          : postingProgress // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc

class _$NewsfeedStateImpl implements _NewsfeedState {
  const _$NewsfeedStateImpl(
      {final List<Post>? posts,
      final Map<String, double> postingProgress = const {}})
      : _posts = posts,
        _postingProgress = postingProgress;

  final List<Post>? _posts;
  @override
  List<Post>? get posts {
    final value = _posts;
    if (value == null) return null;
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, double> _postingProgress;
  @override
  @JsonKey()
  Map<String, double> get postingProgress {
    if (_postingProgress is EqualUnmodifiableMapView) return _postingProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_postingProgress);
  }

  @override
  String toString() {
    return 'NewsfeedState(posts: $posts, postingProgress: $postingProgress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsfeedStateImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality()
                .equals(other._postingProgress, _postingProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_posts),
      const DeepCollectionEquality().hash(_postingProgress));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsfeedStateImplCopyWith<_$NewsfeedStateImpl> get copyWith =>
      __$$NewsfeedStateImplCopyWithImpl<_$NewsfeedStateImpl>(this, _$identity);
}

abstract class _NewsfeedState implements NewsfeedState {
  const factory _NewsfeedState(
      {final List<Post>? posts,
      final Map<String, double> postingProgress}) = _$NewsfeedStateImpl;

  @override
  List<Post>? get posts;
  @override
  Map<String, double> get postingProgress;
  @override
  @JsonKey(ignore: true)
  _$$NewsfeedStateImplCopyWith<_$NewsfeedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
