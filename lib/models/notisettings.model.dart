import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "notisettings.model.freezed.dart";
part "notisettings.model.g.dart";

@freezed
class NotiSettings with _$NotiSettings {
  @JsonSerializable(explicitToJson: true)
  const factory NotiSettings(
      {@BooleanConverter() @JsonKey(name: "like_comment") required bool likeComment,
      @BooleanConverter() @JsonKey(name: "from_friends") required bool fromFriends,
      @BooleanConverter() @JsonKey(name: "requested_friend") required bool requestedFriend,
      @BooleanConverter() @JsonKey(name: "suggested_friend") required bool suggestedFriend,
      @BooleanConverter() @JsonKey(name: "birthday") required bool birthday,
      @BooleanConverter() @JsonKey(name: "video") required bool video,
      @BooleanConverter() @JsonKey(name: "report") required bool report,
      @BooleanConverter() @JsonKey(name: "sound_on") required bool soundOn,
      @BooleanConverter() @JsonKey(name: "notification_on") required bool notificationOn,
      @BooleanConverter() @JsonKey(name: "vibrant_on") required bool vibrantOn,
      @BooleanConverter() @JsonKey(name: "led_on") required bool ledOn}) = _NotiSettings;

  const NotiSettings._();

  List<bool> get types =>
      [likeComment, fromFriends, requestedFriend, suggestedFriend, birthday, video, report];

  List<bool> get methods => [soundOn, notificationOn, vibrantOn, ledOn];

  NotiSettings toggleTypes(int index) => switch (index) {
        0 => copyWith(likeComment: !likeComment),
        1 => copyWith(fromFriends: !fromFriends),
        2 => copyWith(requestedFriend: !requestedFriend),
        3 => copyWith(suggestedFriend: !suggestedFriend),
        4 => copyWith(birthday: !birthday),
        5 => copyWith(video: !video),
        _ => copyWith(report: !report),
      };

  NotiSettings toggleMethod(int index) => switch (index) {
        0 => copyWith(soundOn: !soundOn),
        1 => copyWith(notificationOn: !notificationOn),
        2 => copyWith(vibrantOn: !vibrantOn),
        _ => copyWith(ledOn: !ledOn),
      };

  factory NotiSettings.fromJson(Map<String, dynamic> json) => _$NotiSettingsFromJson(json);
}
