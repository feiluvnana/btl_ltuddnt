import 'package:dio/dio.dart';

class ApiRoot {
  static Future<Dio> _getDio() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    // final String? dataUserId = prefs.getString('userId');

    BaseOptions options = BaseOptions(
      baseUrl: "https://ABC.def/it4788",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // headers: xHeader == true
      //     ? {
      //         'X-Auth-Token': "$token",
      //         'X-User-Id': "$dataUserId",
      //         'Content-Type': 'application/json'
      //       }
      //     : {'authorization': 'Bearer $token'},
    );
    return Dio(options);
  }

  static Future<Map<String, String>?> get(
      String path, Map<String, dynamic>? params) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.get(path, queryParameters: params);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, String>?> post(String path, Object? data) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.post(path, data: data);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, String>?> put(String path, Object? data) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.put(path, data: data);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, String>?> delete(String path, Object? data) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.delete(path, data: data);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
