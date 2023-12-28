import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/author.model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feel.model.freezed.dart';
part 'feel.model.g.dart';

@freezed
class Feel with _$Feel {
  @JsonSerializable(explicitToJson: true)
  const factory Feel(@JsonKey(name: "user") Author author, @FeelTypeConverter() FeelType type) =
      _Feel;

  factory Feel.fromJson(Map<String, dynamic> json) => _$FeelFromJson(json);
}
