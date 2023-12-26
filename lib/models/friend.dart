import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.freezed.dart';
part 'friend.g.dart';

@freezed
class Friend with _$Friend {
  @JsonSerializable(explicitToJson: true)
  const factory Friend(
      @IntegerConverter() int id,
      String username,
      String avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") int sameFriends,
      @DateTimeConverter() DateTime created) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}
