// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      const IntegerOrNullConverter().fromJson(json['id'] as String?),
      json['thumb'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': const IntegerOrNullConverter().toJson(instance.id),
      'thumb': instance.thumb,
      'url': instance.url,
    };
