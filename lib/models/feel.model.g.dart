// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feel.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeelImpl _$$FeelImplFromJson(Map<String, dynamic> json) => _$FeelImpl(
      Author.fromJson(json['user'] as Map<String, dynamic>),
      const FeelTypeConverter().fromJson(json['type'] as String),
    );

Map<String, dynamic> _$$FeelImplToJson(_$FeelImpl instance) =>
    <String, dynamic>{
      'user': instance.author.toJson(),
      'type': const FeelTypeConverter().toJson(instance.type),
    };
