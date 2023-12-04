import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'keyword.model.freezed.dart';
part 'keyword.model.g.dart';

@freezed
class Keyword with _$Keyword {
  @JsonSerializable(explicitToJson: true)
  const factory Keyword(
      @IntegerConverter() int id, String keyword, @DateTimeConverter() DateTime created) = _Keyword;

  factory Keyword.fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);
}
