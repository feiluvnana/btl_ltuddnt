// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blockeduser.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlockedUserImpl _$$BlockedUserImplFromJson(Map<String, dynamic> json) =>
    _$BlockedUserImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['name'] as String,
      json['avatar'] as String,
    );

Map<String, dynamic> _$$BlockedUserImplToJson(_$BlockedUserImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'name': instance.name,
      'avatar': instance.avatar,
    };
