// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      type: const IntegerConverter().fromJson(json['type'] as String),
      group: const IntegerConverter().fromJson(json['group'] as String),
      objectId: const IntegerConverter().fromJson(json['object_id'] as String),
      notificationId:
          const IntegerConverter().fromJson(json['notification_id'] as String),
      created: const DateTimeConverter().fromJson(json['created'] as String),
      read: const BooleanConverter().fromJson(json['read'] as String),
      avatar: json['avatar'] as String,
      title: json['title'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as Map<String, dynamic>?,
      feel: json['feel'] as Map<String, dynamic>?,
      mark: json['mark'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'type': const IntegerConverter().toJson(instance.type),
      'group': const IntegerConverter().toJson(instance.group),
      'object_id': const IntegerConverter().toJson(instance.objectId),
      'notification_id':
          const IntegerConverter().toJson(instance.notificationId),
      'created': const DateTimeConverter().toJson(instance.created),
      'read': const BooleanConverter().toJson(instance.read),
      'avatar': instance.avatar,
      'title': instance.title,
      'user': instance.user.toJson(),
      'post': instance.post,
      'feel': instance.feel,
      'mark': instance.mark,
    };
