// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      const DateTimeConverter().fromJson(json['created'] as String),
      json['content'] as String,
      Author.fromJson(json['poster'] as Map<String, dynamic>),
      (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'created': const DateTimeConverter().toJson(instance.created),
      'content': instance.content,
      'poster': instance.poster.toJson(),
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
