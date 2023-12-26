import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'author.model.freezed.dart';
part 'author.model.g.dart';

@freezed
class Author with _$Author {
  @JsonSerializable(explicitToJson: true)
  const factory Author(@IntegerConverter() int id, String name, String avatar,
      @IntegerOrNullConverter() int? coins, List<dynamic>? listing) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
