// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notisettings.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotiSettings _$NotiSettingsFromJson(Map<String, dynamic> json) {
  return _NotiSettings.fromJson(json);
}

/// @nodoc
mixin _$NotiSettings {
  @BooleanConverter()
  @JsonKey(name: "like_comment")
  bool get likeComment => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "from_friends")
  bool get fromFriends => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "requested_friend")
  bool get requestedFriend => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "suggested_friend")
  bool get suggestedFriend => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "birthday")
  bool get birthday => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "video")
  bool get video => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "report")
  bool get report => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "sound_on")
  bool get soundOn => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "notification_on")
  bool get notificationOn => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "vibrant_on")
  bool get vibrantOn => throw _privateConstructorUsedError;
  @BooleanConverter()
  @JsonKey(name: "led_on")
  bool get ledOn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotiSettingsCopyWith<NotiSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotiSettingsCopyWith<$Res> {
  factory $NotiSettingsCopyWith(
          NotiSettings value, $Res Function(NotiSettings) then) =
      _$NotiSettingsCopyWithImpl<$Res, NotiSettings>;
  @useResult
  $Res call(
      {@BooleanConverter() @JsonKey(name: "like_comment") bool likeComment,
      @BooleanConverter() @JsonKey(name: "from_friends") bool fromFriends,
      @BooleanConverter()
      @JsonKey(name: "requested_friend")
      bool requestedFriend,
      @BooleanConverter()
      @JsonKey(name: "suggested_friend")
      bool suggestedFriend,
      @BooleanConverter() @JsonKey(name: "birthday") bool birthday,
      @BooleanConverter() @JsonKey(name: "video") bool video,
      @BooleanConverter() @JsonKey(name: "report") bool report,
      @BooleanConverter() @JsonKey(name: "sound_on") bool soundOn,
      @BooleanConverter() @JsonKey(name: "notification_on") bool notificationOn,
      @BooleanConverter() @JsonKey(name: "vibrant_on") bool vibrantOn,
      @BooleanConverter() @JsonKey(name: "led_on") bool ledOn});
}

/// @nodoc
class _$NotiSettingsCopyWithImpl<$Res, $Val extends NotiSettings>
    implements $NotiSettingsCopyWith<$Res> {
  _$NotiSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeComment = null,
    Object? fromFriends = null,
    Object? requestedFriend = null,
    Object? suggestedFriend = null,
    Object? birthday = null,
    Object? video = null,
    Object? report = null,
    Object? soundOn = null,
    Object? notificationOn = null,
    Object? vibrantOn = null,
    Object? ledOn = null,
  }) {
    return _then(_value.copyWith(
      likeComment: null == likeComment
          ? _value.likeComment
          : likeComment // ignore: cast_nullable_to_non_nullable
              as bool,
      fromFriends: null == fromFriends
          ? _value.fromFriends
          : fromFriends // ignore: cast_nullable_to_non_nullable
              as bool,
      requestedFriend: null == requestedFriend
          ? _value.requestedFriend
          : requestedFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestedFriend: null == suggestedFriend
          ? _value.suggestedFriend
          : suggestedFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as bool,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as bool,
      soundOn: null == soundOn
          ? _value.soundOn
          : soundOn // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationOn: null == notificationOn
          ? _value.notificationOn
          : notificationOn // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrantOn: null == vibrantOn
          ? _value.vibrantOn
          : vibrantOn // ignore: cast_nullable_to_non_nullable
              as bool,
      ledOn: null == ledOn
          ? _value.ledOn
          : ledOn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotiSettingsImplCopyWith<$Res>
    implements $NotiSettingsCopyWith<$Res> {
  factory _$$NotiSettingsImplCopyWith(
          _$NotiSettingsImpl value, $Res Function(_$NotiSettingsImpl) then) =
      __$$NotiSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@BooleanConverter() @JsonKey(name: "like_comment") bool likeComment,
      @BooleanConverter() @JsonKey(name: "from_friends") bool fromFriends,
      @BooleanConverter()
      @JsonKey(name: "requested_friend")
      bool requestedFriend,
      @BooleanConverter()
      @JsonKey(name: "suggested_friend")
      bool suggestedFriend,
      @BooleanConverter() @JsonKey(name: "birthday") bool birthday,
      @BooleanConverter() @JsonKey(name: "video") bool video,
      @BooleanConverter() @JsonKey(name: "report") bool report,
      @BooleanConverter() @JsonKey(name: "sound_on") bool soundOn,
      @BooleanConverter() @JsonKey(name: "notification_on") bool notificationOn,
      @BooleanConverter() @JsonKey(name: "vibrant_on") bool vibrantOn,
      @BooleanConverter() @JsonKey(name: "led_on") bool ledOn});
}

/// @nodoc
class __$$NotiSettingsImplCopyWithImpl<$Res>
    extends _$NotiSettingsCopyWithImpl<$Res, _$NotiSettingsImpl>
    implements _$$NotiSettingsImplCopyWith<$Res> {
  __$$NotiSettingsImplCopyWithImpl(
      _$NotiSettingsImpl _value, $Res Function(_$NotiSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeComment = null,
    Object? fromFriends = null,
    Object? requestedFriend = null,
    Object? suggestedFriend = null,
    Object? birthday = null,
    Object? video = null,
    Object? report = null,
    Object? soundOn = null,
    Object? notificationOn = null,
    Object? vibrantOn = null,
    Object? ledOn = null,
  }) {
    return _then(_$NotiSettingsImpl(
      likeComment: null == likeComment
          ? _value.likeComment
          : likeComment // ignore: cast_nullable_to_non_nullable
              as bool,
      fromFriends: null == fromFriends
          ? _value.fromFriends
          : fromFriends // ignore: cast_nullable_to_non_nullable
              as bool,
      requestedFriend: null == requestedFriend
          ? _value.requestedFriend
          : requestedFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      suggestedFriend: null == suggestedFriend
          ? _value.suggestedFriend
          : suggestedFriend // ignore: cast_nullable_to_non_nullable
              as bool,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as bool,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as bool,
      soundOn: null == soundOn
          ? _value.soundOn
          : soundOn // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationOn: null == notificationOn
          ? _value.notificationOn
          : notificationOn // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrantOn: null == vibrantOn
          ? _value.vibrantOn
          : vibrantOn // ignore: cast_nullable_to_non_nullable
              as bool,
      ledOn: null == ledOn
          ? _value.ledOn
          : ledOn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$NotiSettingsImpl extends _NotiSettings {
  const _$NotiSettingsImpl(
      {@BooleanConverter()
      @JsonKey(name: "like_comment")
      required this.likeComment,
      @BooleanConverter()
      @JsonKey(name: "from_friends")
      required this.fromFriends,
      @BooleanConverter()
      @JsonKey(name: "requested_friend")
      required this.requestedFriend,
      @BooleanConverter()
      @JsonKey(name: "suggested_friend")
      required this.suggestedFriend,
      @BooleanConverter() @JsonKey(name: "birthday") required this.birthday,
      @BooleanConverter() @JsonKey(name: "video") required this.video,
      @BooleanConverter() @JsonKey(name: "report") required this.report,
      @BooleanConverter() @JsonKey(name: "sound_on") required this.soundOn,
      @BooleanConverter()
      @JsonKey(name: "notification_on")
      required this.notificationOn,
      @BooleanConverter() @JsonKey(name: "vibrant_on") required this.vibrantOn,
      @BooleanConverter() @JsonKey(name: "led_on") required this.ledOn})
      : super._();

  factory _$NotiSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotiSettingsImplFromJson(json);

  @override
  @BooleanConverter()
  @JsonKey(name: "like_comment")
  final bool likeComment;
  @override
  @BooleanConverter()
  @JsonKey(name: "from_friends")
  final bool fromFriends;
  @override
  @BooleanConverter()
  @JsonKey(name: "requested_friend")
  final bool requestedFriend;
  @override
  @BooleanConverter()
  @JsonKey(name: "suggested_friend")
  final bool suggestedFriend;
  @override
  @BooleanConverter()
  @JsonKey(name: "birthday")
  final bool birthday;
  @override
  @BooleanConverter()
  @JsonKey(name: "video")
  final bool video;
  @override
  @BooleanConverter()
  @JsonKey(name: "report")
  final bool report;
  @override
  @BooleanConverter()
  @JsonKey(name: "sound_on")
  final bool soundOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "notification_on")
  final bool notificationOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "vibrant_on")
  final bool vibrantOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "led_on")
  final bool ledOn;

  @override
  String toString() {
    return 'NotiSettings(likeComment: $likeComment, fromFriends: $fromFriends, requestedFriend: $requestedFriend, suggestedFriend: $suggestedFriend, birthday: $birthday, video: $video, report: $report, soundOn: $soundOn, notificationOn: $notificationOn, vibrantOn: $vibrantOn, ledOn: $ledOn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotiSettingsImpl &&
            (identical(other.likeComment, likeComment) ||
                other.likeComment == likeComment) &&
            (identical(other.fromFriends, fromFriends) ||
                other.fromFriends == fromFriends) &&
            (identical(other.requestedFriend, requestedFriend) ||
                other.requestedFriend == requestedFriend) &&
            (identical(other.suggestedFriend, suggestedFriend) ||
                other.suggestedFriend == suggestedFriend) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.report, report) || other.report == report) &&
            (identical(other.soundOn, soundOn) || other.soundOn == soundOn) &&
            (identical(other.notificationOn, notificationOn) ||
                other.notificationOn == notificationOn) &&
            (identical(other.vibrantOn, vibrantOn) ||
                other.vibrantOn == vibrantOn) &&
            (identical(other.ledOn, ledOn) || other.ledOn == ledOn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      likeComment,
      fromFriends,
      requestedFriend,
      suggestedFriend,
      birthday,
      video,
      report,
      soundOn,
      notificationOn,
      vibrantOn,
      ledOn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotiSettingsImplCopyWith<_$NotiSettingsImpl> get copyWith =>
      __$$NotiSettingsImplCopyWithImpl<_$NotiSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotiSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotiSettings extends NotiSettings {
  const factory _NotiSettings(
      {@BooleanConverter()
      @JsonKey(name: "like_comment")
      required final bool likeComment,
      @BooleanConverter()
      @JsonKey(name: "from_friends")
      required final bool fromFriends,
      @BooleanConverter()
      @JsonKey(name: "requested_friend")
      required final bool requestedFriend,
      @BooleanConverter()
      @JsonKey(name: "suggested_friend")
      required final bool suggestedFriend,
      @BooleanConverter()
      @JsonKey(name: "birthday")
      required final bool birthday,
      @BooleanConverter() @JsonKey(name: "video") required final bool video,
      @BooleanConverter() @JsonKey(name: "report") required final bool report,
      @BooleanConverter()
      @JsonKey(name: "sound_on")
      required final bool soundOn,
      @BooleanConverter()
      @JsonKey(name: "notification_on")
      required final bool notificationOn,
      @BooleanConverter()
      @JsonKey(name: "vibrant_on")
      required final bool vibrantOn,
      @BooleanConverter()
      @JsonKey(name: "led_on")
      required final bool ledOn}) = _$NotiSettingsImpl;
  const _NotiSettings._() : super._();

  factory _NotiSettings.fromJson(Map<String, dynamic> json) =
      _$NotiSettingsImpl.fromJson;

  @override
  @BooleanConverter()
  @JsonKey(name: "like_comment")
  bool get likeComment;
  @override
  @BooleanConverter()
  @JsonKey(name: "from_friends")
  bool get fromFriends;
  @override
  @BooleanConverter()
  @JsonKey(name: "requested_friend")
  bool get requestedFriend;
  @override
  @BooleanConverter()
  @JsonKey(name: "suggested_friend")
  bool get suggestedFriend;
  @override
  @BooleanConverter()
  @JsonKey(name: "birthday")
  bool get birthday;
  @override
  @BooleanConverter()
  @JsonKey(name: "video")
  bool get video;
  @override
  @BooleanConverter()
  @JsonKey(name: "report")
  bool get report;
  @override
  @BooleanConverter()
  @JsonKey(name: "sound_on")
  bool get soundOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "notification_on")
  bool get notificationOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "vibrant_on")
  bool get vibrantOn;
  @override
  @BooleanConverter()
  @JsonKey(name: "led_on")
  bool get ledOn;
  @override
  @JsonKey(ignore: true)
  _$$NotiSettingsImplCopyWith<_$NotiSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
