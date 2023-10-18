import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  const factory User(
      @IntegerConverter() int id,
      String username,
      String token,
      String avatar,
      @IntegerConverter() int active,
      @IntegerConverter() int coins) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
