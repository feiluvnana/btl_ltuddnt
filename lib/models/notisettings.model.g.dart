// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notisettings.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotiSettingsImpl _$$NotiSettingsImplFromJson(Map<String, dynamic> json) =>
    _$NotiSettingsImpl(
      likeComment:
          const BooleanConverter().fromJson(json['like_comment'] as String),
      fromFriends:
          const BooleanConverter().fromJson(json['from_friends'] as String),
      requestedFriend:
          const BooleanConverter().fromJson(json['requested_friend'] as String),
      suggestedFriend:
          const BooleanConverter().fromJson(json['suggested_friend'] as String),
      birthday: const BooleanConverter().fromJson(json['birthday'] as String),
      video: const BooleanConverter().fromJson(json['video'] as String),
      report: const BooleanConverter().fromJson(json['report'] as String),
      soundOn: const BooleanConverter().fromJson(json['sound_on'] as String),
      notificationOn:
          const BooleanConverter().fromJson(json['notification_on'] as String),
      vibrantOn:
          const BooleanConverter().fromJson(json['vibrant_on'] as String),
      ledOn: const BooleanConverter().fromJson(json['led_on'] as String),
    );

Map<String, dynamic> _$$NotiSettingsImplToJson(_$NotiSettingsImpl instance) =>
    <String, dynamic>{
      'like_comment': const BooleanConverter().toJson(instance.likeComment),
      'from_friends': const BooleanConverter().toJson(instance.fromFriends),
      'requested_friend':
          const BooleanConverter().toJson(instance.requestedFriend),
      'suggested_friend':
          const BooleanConverter().toJson(instance.suggestedFriend),
      'birthday': const BooleanConverter().toJson(instance.birthday),
      'video': const BooleanConverter().toJson(instance.video),
      'report': const BooleanConverter().toJson(instance.report),
      'sound_on': const BooleanConverter().toJson(instance.soundOn),
      'notification_on':
          const BooleanConverter().toJson(instance.notificationOn),
      'vibrant_on': const BooleanConverter().toJson(instance.vibrantOn),
      'led_on': const BooleanConverter().toJson(instance.ledOn),
    };
