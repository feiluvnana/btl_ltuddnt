// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarkImpl _$$MarkImplFromJson(Map<String, dynamic> json) => _$MarkImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['mark_content'] as String,
      const MarkTypeConverter().fromJson(json['type_of_mark'] as String),
      Author.fromJson(json['poster'] as Map<String, dynamic>),
      const DateTimeConverter().fromJson(json['created'] as String),
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MarkImplToJson(_$MarkImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'mark_content': instance.markContent,
      'type_of_mark': const MarkTypeConverter().toJson(instance.typeOfMark),
      'poster': instance.poster.toJson(),
      'created': const DateTimeConverter().toJson(instance.created),
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
