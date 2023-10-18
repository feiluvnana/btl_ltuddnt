// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['username'] as String,
      json['token'] as String,
      json['avatar'] as String,
      const IntegerConverter().fromJson(json['active'] as String),
      const IntegerConverter().fromJson(json['coins'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'username': instance.username,
      'token': instance.token,
      'avatar': instance.avatar,
      'active': const IntegerConverter().toJson(instance.active),
      'coins': const IntegerConverter().toJson(instance.coins),
    };
