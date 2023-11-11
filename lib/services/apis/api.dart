import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api_root.dart';
import 'package:dio/dio.dart';

class Api {
  Future<Map<String, dynamic>?> signup(String email, String password) async {
    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    var uuid = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    return ApiRoot.post(
        "/signup", jsonEncode({"email": email, "password": password, "uuid": uuid}));
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    var uuid = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    return ApiRoot.post("/login", jsonEncode({"email": email, "password": password, "uuid": uuid}));
  }

  Future<Map<String, dynamic>?> checkVerifyCode(String email, String code) async {
    return ApiRoot.post("/check_verify_code", jsonEncode({"email": email, "code_verify": code}));
  }

  Future<Map<String, dynamic>?> getVerifyCode(String email) async {
    return ApiRoot.post("/get_verify_code", null, {"email": email});
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
                      "${username}_${DateTime.now().millisecondsSinceEpoch}.${avatar.path.split(".").last}")
        }));
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
