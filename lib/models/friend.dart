import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.freezed.dart';
part 'friend.g.dart';

@freezed
class Friend with _$Friend {
  @JsonSerializable(explicitToJson: true)
  const factory Friend(
      @IntegerConverter() int it,
      String username,
      String avatar,
      @IntegerConverter() @JsonKey(name: "same_friends") int sameFriends,
      @DateTimeConverter() DateTime created) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}
