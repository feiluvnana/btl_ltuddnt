import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  const factory User(
      @IntegerConverter() int id,
      String? email,
      String username,
      String? token,
      String avatar,
      @IntegerOrNullConverter() int? active,
      @IntegerOrNullConverter() int? coins) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
