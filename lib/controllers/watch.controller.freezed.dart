// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WatchState {
  List<Post>? get videos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WatchStateCopyWith<WatchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchStateCopyWith<$Res> {
  factory $WatchStateCopyWith(
          WatchState value, $Res Function(WatchState) then) =
      _$WatchStateCopyWithImpl<$Res, WatchState>;
  @useResult
  $Res call({List<Post>? videos});
}

/// @nodoc
class _$WatchStateCopyWithImpl<$Res, $Val extends WatchState>
    implements $WatchStateCopyWith<$Res> {
  _$WatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = freezed,
  }) {
    return _then(_value.copyWith(
      videos: freezed == videos
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<Post>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchStateImplCopyWith<$Res>
    implements $WatchStateCopyWith<$Res> {
  factory _$$WatchStateImplCopyWith(
          _$WatchStateImpl value, $Res Function(_$WatchStateImpl) then) =
      __$$WatchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Post>? videos});
}

/// @nodoc
class __$$WatchStateImplCopyWithImpl<$Res>
    extends _$WatchStateCopyWithImpl<$Res, _$WatchStateImpl>
    implements _$$WatchStateImplCopyWith<$Res> {
  __$$WatchStateImplCopyWithImpl(
      _$WatchStateImpl _value, $Res Function(_$WatchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videos = freezed,
  }) {
    return _then(_$WatchStateImpl(
      videos: freezed == videos
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<Post>?,
    ));
  }
}

/// @nodoc

class _$WatchStateImpl with DiagnosticableTreeMixin implements _WatchState {
  const _$WatchStateImpl({final List<Post>? videos}) : _videos = videos;

  final List<Post>? _videos;
  @override
  List<Post>? get videos {
    final value = _videos;
    if (value == null) return null;
    if (_videos is EqualUnmodifiableListView) return _videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WatchState(videos: $videos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WatchState'))
      ..add(DiagnosticsProperty('videos', videos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchStateImpl &&
            const DeepCollectionEquality().equals(other._videos, _videos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_videos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchStateImplCopyWith<_$WatchStateImpl> get copyWith =>
      __$$WatchStateImplCopyWithImpl<_$WatchStateImpl>(this, _$identity);
}

abstract class _WatchState implements WatchState {
  const factory _WatchState({final List<Post>? videos}) = _$WatchStateImpl;

  @override
  List<Post>? get videos;
  @override
  @JsonKey(ignore: true)
  _$$WatchStateImplCopyWith<_$WatchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
