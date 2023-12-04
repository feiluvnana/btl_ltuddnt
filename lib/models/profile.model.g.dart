// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: const IntegerConverter().fromJson(json['id'] as String),
      username: json['username'] as String,
      created: const DateTimeConverter().fromJson(json['created'] as String),
      description: json['description'] as String,
      avatar: json['avatar'] as String,
      coverImage: json['cover_image'] as String,
      link: json['link'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      listing: const IntegerConverter().fromJson(json['listing'] as String),
      isFriend: const BooleanConverter().fromJson(json['is_friend'] as String),
      online: const BooleanConverter().fromJson(json['online'] as String),
      coins: const IntegerConverter().fromJson(json['coins'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': const IntegerConverter().toJson(instance.id),
      'username': instance.username,
      'created': const DateTimeConverter().toJson(instance.created),
      'description': instance.description,
      'avatar': instance.avatar,
      'cover_image': instance.coverImage,
      'link': instance.link,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'listing': const IntegerConverter().toJson(instance.listing),
      'is_friend': const BooleanConverter().toJson(instance.isFriend),
      'online': const BooleanConverter().toJson(instance.online),
      'coins': const IntegerConverter().toJson(instance.coins),
    };
