import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/author.model.dart';
import 'package:Anti_Fakebook/models/comment.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark.freezed.dart';
part 'mark.g.dart';

@freezed
class Mark with _$Mark {
  @JsonSerializable(explicitToJson: true)
  const factory Mark(
      @IntegerConverter() int id,
      @JsonKey(name: "mark_content") String markContent,
      @MarkTypeConverter() @JsonKey(name: "type_of_mark") MarkType typeOfMark,
      Author poster,
      @DateTimeConverter() DateTime created,
      List<Comment> comments) = _Mark;

  factory Mark.fromJson(Map<String, dynamic> json) => _$MarkFromJson(json);
}
