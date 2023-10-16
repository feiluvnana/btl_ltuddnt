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
      const DateTimeOrNullConverter().fromJson(json['modified'] as String?),
      const IntegerConverter().fromJson(json['fake'] as String),
      const IntegerConverter().fromJson(json['trust'] as String),
      const IntegerConverter().fromJson(json['kudos'] as String),
      const IntegerConverter().fromJson(json['disappointed'] as String),
      const BooleanConverter().fromJson(json['is_rated'] as String),
      const BooleanConverter().fromJson(json['is_marked'] as String),
      (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      Author.fromJson(json['author'] as Map<String, dynamic>),
      Category.fromJson(json['category'] as Map<String, dynamic>),
      json['state'] as String,
      const BooleanConverter().fromJson(json['is_blocked'] as String),
      const BooleanConverter().fromJson(json['can_edit'] as String),
      const BooleanConverter().fromJson(json['banned'] as String),
      const IntegerConverter().fromJson(json['can_mark'] as String),
      const IntegerConverter().fromJson(json['can_rate'] as String),
      json['url'] as String,
      json['messages'] as String,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'name': instance.name,
      'created': const DateTimeConverter().toJson(instance.created),
      'described': instance.described,
      'modified': const DateTimeOrNullConverter().toJson(instance.modified),
      'fake': const IntegerConverter().toJson(instance.fake),
      'trust': const IntegerConverter().toJson(instance.trust),
      'kudos': const IntegerConverter().toJson(instance.kudos),
      'disappointed': const IntegerConverter().toJson(instance.disappointed),
      'is_rated': const BooleanConverter().toJson(instance.isRated),
      'is_marked': const BooleanConverter().toJson(instance.isMarked),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'video': instance.video?.toJson(),
      'author': instance.author.toJson(),
      'category': instance.category.toJson(),
      'state': instance.state,
      'is_blocked': const BooleanConverter().toJson(instance.isBlocked),
      'can_edit': const BooleanConverter().toJson(instance.canEdit),
      'banned': const BooleanConverter().toJson(instance.banned),
      'can_mark': const IntegerConverter().toJson(instance.canMark),
      'can_rate': const IntegerConverter().toJson(instance.canRate),
      'url': instance.url,
      'messages': instance.messages,
    };
