// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      const IntegerConverter().fromJson(json['id'] as String),
      json['name'] as String,
      const DateTimeConverter().fromJson(json['created'] as String),
      json['described'] as String,
      const IntegerOrNullConverter().fromJson(json['feel'] as String?),
      const IntegerOrNullConverter().fromJson(json['comment_mark'] as String?),
      const BooleanConverter().fromJson(json['is_felt'] as String),
      (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      Author.fromJson(json['author'] as Map<String, dynamic>),
      json['state'] as String,
      const BooleanConverter().fromJson(json['is_blocked'] as String),
      const BooleanConverter().fromJson(json['can_edit'] as String),
      const IntegerConverter().fromJson(json['banned'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'name': instance.name,
      'created': const DateTimeConverter().toJson(instance.created),
      'described': instance.described,
      'feel': const IntegerOrNullConverter().toJson(instance.feel),
      'comment_mark':
          const IntegerOrNullConverter().toJson(instance.commentMark),
      'is_felt': const BooleanConverter().toJson(instance.isFelt),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'video': instance.video?.toJson(),
      'author': instance.author.toJson(),
      'state': instance.state,
      'is_blocked': const BooleanConverter().toJson(instance.isBlocked),
      'can_edit': const BooleanConverter().toJson(instance.canEdit),
      'banned': const IntegerConverter().toJson(instance.banned),
    };
