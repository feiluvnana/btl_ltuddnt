// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeywordImpl _$$KeywordImplFromJson(Map<String, dynamic> json) =>
    _$KeywordImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['keyword'] as String,
      const DateTimeConverter().fromJson(json['created'] as String),
    );

Map<String, dynamic> _$$KeywordImplToJson(_$KeywordImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'keyword': instance.keyword,
      'created': const DateTimeConverter().toJson(instance.created),
    };
