import 'dart:convert';
import 'dart:io';

import 'package:Anti_Fakebook/models/notisettings.model.dart';
import 'package:Anti_Fakebook/services/apis/api_root.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class Api {
  Future<Map<String, dynamic>?> signup(String email, String password) async {
    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    var uuid = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    return ApiRoot.post("/signup", jsonEncode({"email": email, "password": password, "uuid": uuid}),
        headers: {});
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    var uuid = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    return ApiRoot.post("/login", jsonEncode({"email": email, "password": password, "uuid": uuid}),
        headers: {});
  }

  Future<Map<String, dynamic>?> checkVerifyCode(String email, String code) async {
    return ApiRoot.post("/check_verify_code", jsonEncode({"email": email, "code_verify": code}));
  }

  Future<Map<String, dynamic>?> getVerifyCode(String email) async {
    return ApiRoot.post("/get_verify_code", jsonEncode({"email": email}));
  }

  Future<Map<String, dynamic>?> changeProfileAfterSignup(String username, [File? avatar]) async {
    return ApiRoot.post(
        "/change_profile_after_signup",
        FormData.fromMap({
          "username": username,
          "avatar": avatar == null
              ? null
              : await MultipartFile.fromFile(avatar.path,
                  filename:
                      "${username}_${DateTime.now().millisecondsSinceEpoch}.${avatar.path.split(".").last}",
                  contentType: MediaType("image", avatar.path.split(".").last))
        }));
  }

  Future<Map<String, dynamic>?> getListPosts(
      {int? userId,
      int? inCampaign,
      int? campaignId,
      required double latitute,
      required double longitute,
      required int lastId,
      int? index}) async {
    return ApiRoot.post(
        "/get_list_posts",
        jsonEncode({
          if (userId != null) "user_id": userId.toString(),
          if (inCampaign != null) "in_campaign": inCampaign.toString(),
          if (campaignId != null) "campaign_id": campaignId.toString(),
          "latitude": latitute.toString(),
          "longitude": longitute.toString(),
          "last_id": lastId.toString(),
          "count": "15",
          "index": "0"
        }));
  }

  Future<Map<String, dynamic>?> getListVideos(
      {int? userId,
      int? inCampaign,
      int? campaignId,
      required double latitute,
      required double longitute,
      required int lastId,
      int? index}) async {
    return ApiRoot.post(
        "/get_list_videos",
        jsonEncode({
          if (userId != null) "user_id": userId.toString(),
          if (inCampaign != null) "in_campaign": inCampaign.toString(),
          if (campaignId != null) "campaign_id": campaignId.toString(),
          "latitude": latitute.toString(),
          "longitude": longitute.toString(),
          "last_id": lastId.toString(),
          "count": "15",
          "index": "0"
        }));
  }

  Future<Map<String, dynamic>?> getPost(int id) async {
    return ApiRoot.post("/get_post", jsonEncode({"id": id.toString()}));
  }

  Future<Map<String, dynamic>?> addPost(
      {List<File>? image,
      File? video,
      String? described,
      String? status,
      void Function(int, int)? onSendProgress}) async {
    return ApiRoot.post(
        "/add_post",
        FormData.fromMap({
          "image": image
              ?.map((e) => MultipartFile.fromFileSync(e.path,
                  contentType: MediaType("image", e.path.split(".").last)))
              .toList(),
          "video": video == null
              ? null
              : await MultipartFile.fromFile(video.path, contentType: MediaType("video", "mp4")),
          "described": described == "" ? " " : described,
          "status": status,
          "auto_accept": "1"
        }),
        onSendProgress: onSendProgress);
  }

  Future<Map<String, dynamic>?> editPost(
      {required int id,
      List<File>? image,
      File? video,
      String? described,
      String? status,
      List<int>? imageDel,
      List<int>? imageSort}) async {
    return ApiRoot.post(
        "/edit_post",
        FormData.fromMap({
          "id": id.toString(),
          if (described != null) "described": described,
          if (image != null)
            "image": image
                .map((e) => MultipartFile.fromFileSync(e.path,
                    contentType: MediaType("image", e.path.split(".").last)))
                .toList(),
          if (video != null)
            "video":
                await MultipartFile.fromFile(video.path, contentType: MediaType("video", "mp4")),
          if (status != null) "status": status,
          if (imageDel != null) "image_del": imageDel.map<String>((e) => e.toString()).join(","),
          if (imageSort != null) "image_sort": imageSort.map<String>((e) => e.toString()).join(","),
          "auto_accept": "1"
        }));
  }

  Future<Map<String, dynamic>?> changePassword(String password, String newPassword) async {
    return ApiRoot.post(
        "/change_password", jsonEncode({"password": password, "new_password": newPassword}));
  }

  Future<Map<String, dynamic>?> resetPassword(String email, String code, String password) async {
    return ApiRoot.post(
        "/reset_password", jsonEncode({"email": email, "password": password, "code": code}));
  }

  Future<Map<String, dynamic>?> logout() async {
    return ApiRoot.post("/logout", null);
  }

  Future<Map<String, dynamic>?> reportPost(int id, String subject, String detail) async {
    return ApiRoot.post(
        "/report_post", jsonEncode({"id": id.toString(), "subject": subject, "details": detail}));
  }

  Future<Map<String, dynamic>?> deletePost(int id) async {
    return ApiRoot.post("/delete_post", jsonEncode({"id": id.toString()}));
  }

  Future<Map<String, dynamic>?> unblock(int id) async {
    return ApiRoot.post("/unblock", jsonEncode({"user_id": id.toString()}));
  }

  Future<Map<String, dynamic>?> getSuggestedFriends(int index) async {
    return ApiRoot.post("/get_suggested_friends", jsonEncode({"index": index, "count": 15}));
  }

  Future<Map<String, dynamic>?> feel(int id, int type) async {
    return ApiRoot.post("/feel", jsonEncode({"id": id, "type": type}));
  }

  Future<Map<String, dynamic>?> getMarkComment(int id, int index, int count) {
    return ApiRoot.post(
        "/get_mark_comment", jsonEncode({"id": id, "index": index, "count": count}));
  }

  Future<Map<String, dynamic>?> getPushSettings() {
    return ApiRoot.post("/get_push_settings", null);
  }

  Future<Map<String, dynamic>?> setPushSettings(NotiSettings notiSettings) {
    return ApiRoot.post("/set_push_settings", jsonEncode(notiSettings.toJson()));
  }

  Future<Map<String, dynamic>?> setRequestFriend(int userId) {
    return ApiRoot.post("/set_request_friend", jsonEncode({"user_id": userId}));
  }

  Future<Map<String, dynamic>?> setAcceptFriend(int userId, int isAccept) {
    return ApiRoot.post(
        "/set_accept_friend", jsonEncode({"user_id": userId, "is_accept": isAccept.toString()}));
  }

  Future<Map<String, dynamic>?> unfriend(int userId) {
    return ApiRoot.post("/unfriend", jsonEncode({"user_id": userId}));
  }

  Future<Map<String, dynamic>?> setMarkComment(
      {required int id, required String content, int? markId, int? type}) {
    return ApiRoot.post(
        "/set_mark_comment",
        jsonEncode({
          "id": id,
          "content": content,
          "index": "0",
          "count": "10",
          if (markId != null) "mark_id": markId,
          if (type != null) "type": type
        }));
  }

  Future<Map<String, dynamic>?> getRequestedFriends(int index) async {
    return ApiRoot.post("/get_requested_friends", jsonEncode({"index": index, "count": 15}));
  }

  Future<Map<String, dynamic>?> getUserFriends(int index, int userId, [int count = 15]) async {
    return ApiRoot.post(
        "/get_user_friends", jsonEncode({"index": index, "count": count, "user_id": userId}));
  }

  Future<Map<String, dynamic>?> getListBlocks(int index) async {
    return ApiRoot.post("/get_list_blocks", jsonEncode({"index": index, "count": 15}));
  }

  Future<Map<String, dynamic>?> setBlock(int id) async {
    return ApiRoot.post("/set_block", jsonEncode({"user_id": id}));
  }

  Future<Map<String, dynamic>?> getUserInfo(int? id) async {
    return ApiRoot.post("/get_user_info", (id != null) ? jsonEncode({"user_id": id}) : id);
  }

  Future<Map<String, dynamic>?> search(
      {required String keyword, required int userId, required int index}) async {
    return ApiRoot.post("/search",
        jsonEncode({"keyword": keyword, "user_id": userId, "index": index, "count": 15}));
  }

  Future<Map<String, dynamic>?> searchUser(
      {required String keyword, required int userId, required int index}) async {
    return ApiRoot.post(
        "/search_user", jsonEncode({"keyword": keyword, "index": index, "count": 15}));
  }

  Future<Map<String, dynamic>?> getSavedSearch() async {
    return ApiRoot.post("/get_saved_search", jsonEncode({"index": 0, "count": 20}));
  }

  Future<Map<String, dynamic>?> delSavedSearch({int? searchId, int? all}) async {
    return ApiRoot.post("/del_saved_search",
        jsonEncode({if (searchId != null) "search_id": searchId, if (all != null) "all": all}));
  }

  Future<Map<String, dynamic>?> setDevToken() async {
    return ApiRoot.post("/set_devtoken",
        jsonEncode({"devtype": "1", "devtoken": await FirebaseMessaging.instance.getToken()}));
  }

  Future<Map<String, dynamic>?> checkEmail(String email) async {
    return ApiRoot.post("/check_email", jsonEncode({"email": email}));
  }

  Future<Map<String, dynamic>?> getNotification(int index) async {
    return ApiRoot.post("/get_notification", jsonEncode({"index": index, "count": 20}));
  }

  Future<Map<String, dynamic>?> setUserInfo(
      {String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      File? coverImage,
      File? avatar,
      String? link}) async {
    return ApiRoot.post(
        "/set_user_info",
        FormData.fromMap({
          if (username != null) "username": username,
          if (description != null) "description": description,
          if (avatar != null)
            "avatar": await MultipartFile.fromFile(avatar.path,
                contentType: MediaType("image", avatar.path.split(".").last)),
          if (address != null) "address": address,
          if (city != null) "city": city,
          if (country != null) "country": country,
          if (coverImage != null)
            "cover_image": await MultipartFile.fromFile(coverImage.path,
                contentType: MediaType("image", coverImage.path.split(".").last)),
          if (link != null) "link": link
        }));
  }
}
