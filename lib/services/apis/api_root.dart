import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRoot {
  static Future<Dio> _getDio() async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://it4788.catan.io.vn/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'authorization': 'Bearer ${await secureStorage.read(key: "token")}'},
    );
    return Dio(options);
  }

  static Future<Map<String, String>?> get(String path, Map<String, dynamic>? params) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.get(path, queryParameters: params);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> post(String path, Object? data,
      [Map<String, dynamic>? params]) async {
    try {
      Dio dio = await _getDio();
      var response = await dio.post(path, data: data, queryParameters: params);
      if (kDebugMode) {
        print(
            "Method:POST\nURL:${response.realUri}\nBody:$data\nStatus:${response.statusCode}\nResponse:${response.data}");
      }
      return response.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(
            "Method:POST\nURL:${e.response?.realUri}\nBody:$data\nStatus:${e.response?.statusCode}\nResponse:${e.response?.data}");
      }
      return e.response?.data;
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
