import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  @JsonSerializable(explicitToJson: true)
  const factory Video(@IntegerOrNullConverter() int? id, String? thumb, String? url) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
