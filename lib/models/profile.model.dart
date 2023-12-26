import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "profile.model.freezed.dart";
part "profile.model.g.dart";

@freezed
class Profile with _$Profile {
  @JsonSerializable(explicitToJson: true)
  const factory Profile(
      {@IntegerConverter() required int id,
      required String username,
      @DateTimeConverter() required DateTime created,
      required String description,
      required String avatar,
      @JsonKey(name: "cover_image") required String coverImage,
      required String link,
      required String address,
      required String city,
      required String country,
      @IntegerConverter() required int listing,
      @JsonKey(name: "is_friend") @BooleanConverter() required bool isFriend,
      @BooleanConverter() required bool online,
      @IntegerConverter() required int coins}) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
