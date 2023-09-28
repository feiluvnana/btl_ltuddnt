import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api_root.dart';
import 'package:dio/dio.dart';

class Api {
  static Future<Map<String, String>?>? signup(
      String email, String password, String uuid) {
    return ApiRoot.post("signup",
        FormData.fromMap({"email": email, "password": password, "uuid": uuid}));
  }

  static Future<Map<String, String>?>? login(String email, String password) {
    return ApiRoot.post(
        "login", FormData.fromMap({"email": email, "password": password}));
  }
}
