// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: const IntegerConverter().fromJson(json['id'] as String),
      name: json['name'] as String,
      created: const DateTimeConverter().fromJson(json['created'] as String),
      described: json['described'] as String,
      modified: json['modified'] == null
          ? false
          : const BooleanConverter().fromJson(json['modified'] as String),
      fake: json['fake'] == null
          ? 0
          : const IntegerConverter().fromJson(json['fake'] as String),
      trust: json['trust'] == null
          ? 0
          : const IntegerConverter().fromJson(json['trust'] as String),
      kudos: json['kudos'] == null
          ? 0
          : const IntegerConverter().fromJson(json['kudos'] as String),
      feel: json['feel'] == null
          ? 0
          : const IntegerConverter().fromJson(json['feel'] as String),
      commentMark: json['comment_mark'] == null
          ? 0
          : const IntegerConverter().fromJson(json['comment_mark'] as String),
      disappointed: json['disappointed'] == null
          ? 0
          : const IntegerConverter().fromJson(json['disappointed'] as String),
      isFelt: const FeelTypeConverter().fromJson(json['is_felt'] as String),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      state: json['state'] as String,
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
      'modified': const BooleanConverter().toJson(instance.modified),
      'fake': const IntegerConverter().toJson(instance.fake),
      'trust': const IntegerConverter().toJson(instance.trust),
      'kudos': const IntegerConverter().toJson(instance.kudos),
      'feel': const IntegerConverter().toJson(instance.feel),
      'comment_mark': const IntegerConverter().toJson(instance.commentMark),
      'disappointed': const IntegerConverter().toJson(instance.disappointed),
      'is_felt': const FeelTypeConverter().toJson(instance.isFelt),
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'video': instance.video?.toJson(),
      'author': instance.author.toJson(),
      'state': instance.state,
      'is_blocked': const BooleanConverter().toJson(instance.isBlocked),
      'can_edit': const BooleanConverter().toJson(instance.canEdit),
      'banned': const IntegerConverter().toJson(instance.banned),
    };
