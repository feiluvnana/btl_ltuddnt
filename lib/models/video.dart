import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  @JsonSerializable(explicitToJson: true)
  const factory Video(@IntegerConverter() int id, String thumb, String url) =
      _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}