import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'blockeduser.model.freezed.dart';
part 'blockeduser.model.g.dart';

@freezed
class BlockedUser with _$BlockedUser {
  @JsonSerializable(explicitToJson: true)
  const factory BlockedUser(@IntegerConverter() int id, String name, String avatar) = _BlockedUser;

  factory BlockedUser.fromJson(Map<String, dynamic> json) => _$BlockedUserFromJson(json);
}
