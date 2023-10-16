// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newfeeds_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewfeedsState {
  List<Post> get posts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewfeedsStateCopyWith<NewfeedsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewfeedsStateCopyWith<$Res> {
  factory $NewfeedsStateCopyWith(
          NewfeedsState value, $Res Function(NewfeedsState) then) =
      _$NewfeedsStateCopyWithImpl<$Res, NewfeedsState>;
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class _$NewfeedsStateCopyWithImpl<$Res, $Val extends NewfeedsState>
    implements $NewfeedsStateCopyWith<$Res> {
  _$NewfeedsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_value.copyWith(
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewfeedsStateImplCopyWith<$Res>
    implements $NewfeedsStateCopyWith<$Res> {
  factory _$$NewfeedsStateImplCopyWith(
          _$NewfeedsStateImpl value, $Res Function(_$NewfeedsStateImpl) then) =
      __$$NewfeedsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class __$$NewfeedsStateImplCopyWithImpl<$Res>
    extends _$NewfeedsStateCopyWithImpl<$Res, _$NewfeedsStateImpl>
    implements _$$NewfeedsStateImplCopyWith<$Res> {
  __$$NewfeedsStateImplCopyWithImpl(
      _$NewfeedsStateImpl _value, $Res Function(_$NewfeedsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_$NewfeedsStateImpl(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$NewfeedsStateImpl
    with DiagnosticableTreeMixin
    implements _NewfeedsState {
  const _$NewfeedsStateImpl({final List<Post> posts = const []})
      : _posts = posts;

  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewfeedsState(posts: $posts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewfeedsState'))
      ..add(DiagnosticsProperty('posts', posts));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewfeedsStateImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewfeedsStateImplCopyWith<_$NewfeedsStateImpl> get copyWith =>
      __$$NewfeedsStateImplCopyWithImpl<_$NewfeedsStateImpl>(this, _$identity);
}

abstract class _NewfeedsState implements NewfeedsState {
  const factory _NewfeedsState({final List<Post> posts}) = _$NewfeedsStateImpl;

  @override
  List<Post> get posts;
  @override
  @JsonKey(ignore: true)
  _$$NewfeedsStateImplCopyWith<_$NewfeedsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
