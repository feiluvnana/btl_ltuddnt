import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'notification.model.freezed.dart';
part 'notification.model.g.dart';

@freezed
class Notification with _$Notification {
  @JsonSerializable(explicitToJson: true)
  const factory Notification({
    @IntegerConverter() required int type,
    @IntegerConverter() required int group,
    @IntegerConverter() @JsonKey(name: "object_id") required int objectId,
    @IntegerConverter() @JsonKey(name: "notification_id") required int notificationId,
    @DateTimeConverter() required DateTime created,
    @BooleanConverter() required bool read,
    required String avatar,
    required String title,
    required User user,
    Map<String, dynamic>? post,
    Map<String, dynamic>? feel,
    Map<String, dynamic>? mark,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}
