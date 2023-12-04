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
      _$JsonConverterFromJson<String, bool>(
          json['modified'], const BooleanConverter().fromJson),
      const IntegerOrNullConverter().fromJson(json['fake'] as String?),
      const IntegerOrNullConverter().fromJson(json['trust'] as String?),
      const IntegerOrNullConverter().fromJson(json['kudos'] as String?),
      const IntegerOrNullConverter().fromJson(json['feel'] as String?),
      const IntegerOrNullConverter().fromJson(json['comment_mark'] as String?),
      const IntegerOrNullConverter().fromJson(json['disappointed'] as String?),
      const FeelTypeConverter().fromJson(json['is_felt'] as String),
      (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      Author.fromJson(json['author'] as Map<String, dynamic>),
      json['state'] as String,
      isBlocked: json['is_blocked'] == null
          ? false
          : const BooleanConverter().fromJson(json['is_blocked'] as String),
      canEdit: json['can_edit'] == null
          ? false
          : const BooleanConverter().fromJson(json['can_edit'] as String),
      banned: json['banned'] == null
          ? 0
          : const IntegerConverter().fromJson(json['banned'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'name': instance.name,
      'created': const DateTimeConverter().toJson(instance.created),
      'described': instance.described,
      'modified': _$JsonConverterToJson<String, bool>(
          instance.modified, const BooleanConverter().toJson),
      'fake': const IntegerOrNullConverter().toJson(instance.fake),
      'trust': const IntegerOrNullConverter().toJson(instance.trust),
      'kudos': const IntegerOrNullConverter().toJson(instance.kudos),
      'feel': const IntegerOrNullConverter().toJson(instance.feel),
      'comment_mark':
          const IntegerOrNullConverter().toJson(instance.commentMark),
      'disappointed':
          const IntegerOrNullConverter().toJson(instance.disappointed),
      'is_felt': const FeelTypeConverter().toJson(instance.isFelt),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'video': instance.video?.toJson(),
      'author': instance.author.toJson(),
      'state': instance.state,
      'is_blocked': const BooleanConverter().toJson(instance.isBlocked),
      'can_edit': const BooleanConverter().toJson(instance.canEdit),
      'banned': const IntegerConverter().toJson(instance.banned),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
