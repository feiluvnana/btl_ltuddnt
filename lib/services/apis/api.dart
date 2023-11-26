import 'dart:convert';
import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api_root.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
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
      {required int userId,
      required int inCampaign,
      required int campaignId,
      required double latitute,
      required double longitute,
      required int lastId,
      int? index,
      int? count}) async {
    return ApiRoot.post(
        "/get_list_posts",
        jsonEncode({
          "user_id": userId.toString(),
          "in_campaign": inCampaign.toString(),
          "campaign_id": campaignId.toString(),
          "latitude": latitute.toString(),
          "longitude": longitute.toString(),
          "last_id": lastId.toString(),
          "index": index?.toString(),
          "count": count?.toString()
        }));
  }

  Future<Map<String, dynamic>?> addPost(
      {List<File>? image, File? video, String? described, String? status}) async {
    return ApiRoot.post(
        "/add_post",
        FormData.fromMap({
          "image": image?.map((e) => MultipartFile.fromFileSync(e.path)).toList(),
          "video": video == null
              ? null
              : await MultipartFile.fromFile(video.path, contentType: MediaType("video", "mp4")),
          "described": described,
          "status": status,
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

  Future<Map<String, dynamic>?> getSuggestedFriends(int index) async {
    return ApiRoot.post("/get_suggested_friends", jsonEncode({"index": index, "count": 100}));
  }

  Future<Map<String, dynamic>?> feel(int id, int type) async {
    return ApiRoot.post("/feel", jsonEncode({"id": id.toString(), "type": type.toString()}));
  }

  Future<Map<String, dynamic>?> getMarkComment(int id, int index, int count) {
    return ApiRoot.post("/get_mark_comment",
        jsonEncode({"id": id.toString(), "index": index.toString(), "count": count.toString()}));
  }

  // static Future<Map<String, String>?> logout() async {
  //   return ApiRoot.post("/logout", FormData.fromMap({"token": ""}));
  // }

  // static Future<Map<String, String>?> getVerifyCode(String email) async {
  //   return ApiRoot.post("/get_verify_code", FormData.fromMap({"email": email}));
  // }

  // static Future<Map<String, String>?> checkVerifyCode(String email, String code) async {
  //   return ApiRoot.post(
  //       "/check_verify_code", FormData.fromMap({"email": email, "code_verify": code}));
  // }

  // static Future<Map<String, String>?> changeInfoAfterSignup(String email, File? avatar) async {
  //   return ApiRoot.post(
  //       "/change_info_after_signup",
  //       FormData.fromMap({
  //         "token": "",
  //         "email": email,
  //         "avatar": avatar == null ? null : await MultipartFile.fromFile(avatar.path)
  //       }));
  // }

  // static Future<Map<String, String>?> addPost(
  //     String described, List<File>? image, File? video, String? status) async {
  //   return ApiRoot.post(
  //       "/add_post",
  //       FormData.fromMap({
  //         "token": "",
  //         "status": status,
  //         "video": video == null ? null : await MultipartFile.fromFile(video.path),
  //         "described": described,
  //         "image": image?.map((e) async => await MultipartFile.fromFile(e.path))
  //       }));
  // }

  // static Future<Map<String, String>?> getMarkComment(int id, int index, int count) async {
  //   return {
  //     "code": "1000",
  //     "message": "OK",
  //     "data": jsonEncode([
  //       {
  //         "id": 0,
  //         "mark_content": "test",
  //         "type_of_mark": "trust",
  //         "poster": jsonEncode({"id": "1", "name": "Mark xoăn", "avatar": "///"}),
  //         "comments": jsonEncode({
  //           "created": DateTime.now().millisecondsSinceEpoch.toString(),
  //           "content": "Comment",
  //           "comments": "[]"
  //         })
  //       }
  //     ]),
  //     "is_blocked": "true"
  //   };
  // }
}
