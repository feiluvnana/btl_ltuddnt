// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
mixin _$Notification {
  @IntegerConverter()
  int get type => throw _privateConstructorUsedError;
  @IntegerConverter()
  int get group => throw _privateConstructorUsedError;
  @IntegerConverter()
  @JsonKey(name: "object_id")
  int get objectId => throw _privateConstructorUsedError;
  @IntegerConverter()
  @JsonKey(name: "notification_id")
  int get notificationId => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get created => throw _privateConstructorUsedError;
  @BooleanConverter()
  bool get read => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  Map<String, dynamic>? get post => throw _privateConstructorUsedError;
  Map<String, dynamic>? get feel => throw _privateConstructorUsedError;
  Map<String, dynamic>? get mark => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {@IntegerConverter() int type,
      @IntegerConverter() int group,
      @IntegerConverter() @JsonKey(name: "object_id") int objectId,
      @IntegerConverter() @JsonKey(name: "notification_id") int notificationId,
      @DateTimeConverter() DateTime created,
      @BooleanConverter() bool read,
      String avatar,
      String title,
      User user,
      Map<String, dynamic>? post,
      Map<String, dynamic>? feel,
      Map<String, dynamic>? mark});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? group = null,
    Object? objectId = null,
    Object? notificationId = null,
    Object? created = null,
    Object? read = null,
    Object? avatar = null,
    Object? title = null,
    Object? user = null,
    Object? post = freezed,
    Object? feel = freezed,
    Object? mark = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int,
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      feel: freezed == feel
          ? _value.feel
          : feel // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      mark: freezed == mark
          ? _value.mark
          : mark // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@IntegerConverter() int type,
      @IntegerConverter() int group,
      @IntegerConverter() @JsonKey(name: "object_id") int objectId,
      @IntegerConverter() @JsonKey(name: "notification_id") int notificationId,
      @DateTimeConverter() DateTime created,
      @BooleanConverter() bool read,
      String avatar,
      String title,
      User user,
      Map<String, dynamic>? post,
      Map<String, dynamic>? feel,
      Map<String, dynamic>? mark});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? group = null,
    Object? objectId = null,
    Object? notificationId = null,
    Object? created = null,
    Object? read = null,
    Object? avatar = null,
    Object? title = null,
    Object? user = null,
    Object? post = freezed,
    Object? feel = freezed,
    Object? mark = freezed,
  }) {
    return _then(_$NotificationImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int,
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      post: freezed == post
          ? _value._post
          : post // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      feel: freezed == feel
          ? _value._feel
          : feel // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      mark: freezed == mark
          ? _value._mark
          : mark // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$NotificationImpl with DiagnosticableTreeMixin implements _Notification {
  const _$NotificationImpl(
      {@IntegerConverter() required this.type,
      @IntegerConverter() required this.group,
      @IntegerConverter() @JsonKey(name: "object_id") required this.objectId,
      @IntegerConverter()
      @JsonKey(name: "notification_id")
      required this.notificationId,
      @DateTimeConverter() required this.created,
      @BooleanConverter() required this.read,
      required this.avatar,
      required this.title,
      required this.user,
      final Map<String, dynamic>? post,
      final Map<String, dynamic>? feel,
      final Map<String, dynamic>? mark})
      : _post = post,
        _feel = feel,
        _mark = mark;

  factory _$NotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationImplFromJson(json);

  @override
  @IntegerConverter()
  final int type;
  @override
  @IntegerConverter()
  final int group;
  @override
  @IntegerConverter()
  @JsonKey(name: "object_id")
  final int objectId;
  @override
  @IntegerConverter()
  @JsonKey(name: "notification_id")
  final int notificationId;
  @override
  @DateTimeConverter()
  final DateTime created;
  @override
  @BooleanConverter()
  final bool read;
  @override
  final String avatar;
  @override
  final String title;
  @override
  final User user;
  final Map<String, dynamic>? _post;
  @override
  Map<String, dynamic>? get post {
    final value = _post;
    if (value == null) return null;
    if (_post is EqualUnmodifiableMapView) return _post;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _feel;
  @override
  Map<String, dynamic>? get feel {
    final value = _feel;
    if (value == null) return null;
    if (_feel is EqualUnmodifiableMapView) return _feel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _mark;
  @override
  Map<String, dynamic>? get mark {
    final value = _mark;
    if (value == null) return null;
    if (_mark is EqualUnmodifiableMapView) return _mark;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Notification(type: $type, group: $group, objectId: $objectId, notificationId: $notificationId, created: $created, read: $read, avatar: $avatar, title: $title, user: $user, post: $post, feel: $feel, mark: $mark)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Notification'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('notificationId', notificationId))
      ..add(DiagnosticsProperty('created', created))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('post', post))
      ..add(DiagnosticsProperty('feel', feel))
      ..add(DiagnosticsProperty('mark', mark));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._post, _post) &&
            const DeepCollectionEquality().equals(other._feel, _feel) &&
            const DeepCollectionEquality().equals(other._mark, _mark));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      group,
      objectId,
      notificationId,
      created,
      read,
      avatar,
      title,
      user,
      const DeepCollectionEquality().hash(_post),
      const DeepCollectionEquality().hash(_feel),
      const DeepCollectionEquality().hash(_mark));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationImplToJson(
      this,
    );
  }
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {@IntegerConverter() required final int type,
      @IntegerConverter() required final int group,
      @IntegerConverter()
      @JsonKey(name: "object_id")
      required final int objectId,
      @IntegerConverter()
      @JsonKey(name: "notification_id")
      required final int notificationId,
      @DateTimeConverter() required final DateTime created,
      @BooleanConverter() required final bool read,
      required final String avatar,
      required final String title,
      required final User user,
      final Map<String, dynamic>? post,
      final Map<String, dynamic>? feel,
      final Map<String, dynamic>? mark}) = _$NotificationImpl;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$NotificationImpl.fromJson;

  @override
  @IntegerConverter()
  int get type;
  @override
  @IntegerConverter()
  int get group;
  @override
  @IntegerConverter()
  @JsonKey(name: "object_id")
  int get objectId;
  @override
  @IntegerConverter()
  @JsonKey(name: "notification_id")
  int get notificationId;
  @override
  @DateTimeConverter()
  DateTime get created;
  @override
  @BooleanConverter()
  bool get read;
  @override
  String get avatar;
  @override
  String get title;
  @override
  User get user;
  @override
  Map<String, dynamic>? get post;
  @override
  Map<String, dynamic>? get feel;
  @override
  Map<String, dynamic>? get mark;
  @override
  @JsonKey(ignore: true)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
