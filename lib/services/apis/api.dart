import 'dart:convert';
import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/data.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api_root.dart';
import 'package:dio/dio.dart';

class Api {
  static Future<Map<String, String>?> signup(String email, String password) async {
    return signup_res[0];
    // var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    // var uuid = '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    // return ApiRoot.post("/signup",
    //     FormData.fromMap({"email": email, "password": password, "uuid": uuid}));
  }

  static Future<Map<String, String>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1), () {});
    return (email == "doicoluu1234@gmail.com" && password == "abc12345")
        ? login_res[0]
        : login_res[1];
    // return ApiRoot.post(
    //     "/login", FormData.fromMap({"email": email, "password": password}));
  }

  static Future<Map<String, String>?> logout() async {
    return ApiRoot.post("/logout", FormData.fromMap({"token": ""}));
  }

  static Future<Map<String, String>?> getVerifyCode(String email) async {
    return ApiRoot.post("/get_verify_code", FormData.fromMap({"email": email}));
  }

  static Future<Map<String, String>?> checkVerifyCode(String email, String code) async {
    return ApiRoot.post(
        "/check_verify_code", FormData.fromMap({"email": email, "code_verify": code}));
  }

  static Future<Map<String, String>?> changeInfoAfterSignup(String email, File? avatar) async {
    return ApiRoot.post(
        "/change_info_after_signup",
        FormData.fromMap({
          "token": "",
          "email": email,
          "avatar": avatar == null ? null : await MultipartFile.fromFile(avatar.path)
        }));
  }

  static Future<Map<String, String>?> addPost(
      String described, List<File>? image, File? video, String? status) async {
    return ApiRoot.post(
        "/add_post",
        FormData.fromMap({
          "token": "",
          "status": status,
          "video": video == null ? null : await MultipartFile.fromFile(video.path),
          "described": described,
          "image": image?.map((e) async => await MultipartFile.fromFile(e.path))
        }));
  }

  static Future<Map<String, String>?> getMarkComment(int id, int index, int count) async {
    return {
      "code": "1000",
      "message": "OK",
      "data": jsonEncode([
        {
          "id": 0,
          "mark_content": "test",
          "type_of_mark": "trust",
          "poster": jsonEncode({"id": "1", "name": "Mark xoăn", "avatar": "///"}),
          "comments": jsonEncode({
            "created": DateTime.now().millisecondsSinceEpoch.toString(),
            "content": "Comment",
            "comments": "[]"
          })
        }
      ]),
      "is_blocked": "true"
    };
  }
}
