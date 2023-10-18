import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
class Image with _$Image {
  @JsonSerializable(explicitToJson: true)
  const factory Image(@IntegerConverter() int id, String url) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
