// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['name'] as String,
      json['avatar'] as String,
      const IntegerConverter().fromJson(json['coins'] as String),
      json['listing'] as String,
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'name': instance.name,
      'avatar': instance.avatar,
      'coins': const IntegerConverter().toJson(instance.coins),
      'listing': instance.listing,
    };
