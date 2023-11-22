// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      const IntegerConverter().fromJson(json['it'] as String),
      json['username'] as String,
      json['avatar'] as String,
      const IntegerConverter().fromJson(json['same_friends'] as String),
      const DateTimeConverter().fromJson(json['created'] as String),
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'it': const IntegerConverter().toJson(instance.it),
      'username': instance.username,
      'avatar': instance.avatar,
      'same_friends': const IntegerConverter().toJson(instance.sameFriends),
      'created': const DateTimeConverter().toJson(instance.created),
    };
