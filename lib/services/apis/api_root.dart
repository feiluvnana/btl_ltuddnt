import 'dart:convert';
import 'package:Anti_Fakebook/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CancelTokenManager {
  final List<CancelToken> _cancelTokens = [];

  CancelToken createCancelToken() {
    CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);
    return cancelToken;
  }

  void cancelAllRequests() {
    for (var cancelToken in _cancelTokens) {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel("Request cancelled due to an error");
      }
    }
    _cancelTokens.clear();
  }
}

class ApiRoot {
  static CancelTokenManager cancelTokenManager = CancelTokenManager();

  static Dio createDioInstance() {
    return Dio(BaseOptions(
        baseUrl: "https://it4788.catan.io.vn/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (_) => true))
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.cancelToken = cancelTokenManager.createCancelToken();
        String? token = await secureStorage.read(key: "user").then((value) {
          if (value == null) return null;
          return jsonDecode(value)["token"];
        });
        if (token == null &&
            [
              "/signup",
              "/login",
              "/get_verify_code",
              "/check_verify_code",
              "/reset_password",
              "/check_email",
              "/restore_user"
            ].contains(options.path)) {
          handler.next(options);
          return;
        }
        if (token == null &&
            ![
              "/signup",
              "/login",
              "/get_verify_code",
              "/check_verify_code",
              "/reset_password",
              "/check_email",
              "/restore_user"
            ].contains(options.path)) {
          cancelTokenManager.cancelAllRequests();
          handler.reject(DioException(requestOptions: options, type: DioExceptionType.cancel));
          navigatorKey.currentState!.pushNamedAndRemoveUntil("/login", (route) => false);
          return;
        }
        options.headers.addAll({"authorization": "Bearer $token"});
        handler.next(options);
      }, onResponse: (response, handler) async {
        debugPrint(
            "${response.requestOptions.method.toUpperCase()} ${response.realUri} HTTP/1.1\nHeader:${response.requestOptions.headers}\nPayload:\n\t1.Query: ${response.requestOptions.queryParameters}\n\t2.Data: ${response.requestOptions.data}\nStatus Code: ${response.statusCode} ${response.statusMessage}\nData: ${response.data}");
        if (response.data["code"] == "9998") {
          navigatorKey.currentState?.pushNamedAndRemoveUntil("/login", (route) => false);
          cancelTokenManager.cancelAllRequests();
          handler.reject(DioException(
              requestOptions: response.requestOptions, type: DioExceptionType.unknown));
        }
        if (response.statusCode == 400) {
          handler.reject(DioException(
              requestOptions: response.requestOptions, type: DioExceptionType.unknown));
          return;
        }
        handler.next(response);
      }, onError: (exception, handler) {
        var response = exception.response;
        debugPrint(
            "${response?.requestOptions.method.toUpperCase()} ${response?.realUri} HTTP/1.1\nHeader:${response?.requestOptions.headers}\nPayload:\n\t1.Query: ${response?.requestOptions.queryParameters}\n\t2.Data: ${response?.requestOptions.data}\nStatus Code: ${response?.statusCode} ${response?.statusMessage}\nData: ${response?.data}");
        handler.reject(exception);
        cancelTokenManager.cancelAllRequests();
      }));
  }

  static Future<Map<String, String>?> get(String path, Map<String, dynamic>? params) async {
    try {
      var response = await createDioInstance().get(path, queryParameters: params);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> post(String path, Object? data,
      {Map<String, dynamic>? headers, void Function(int, int)? onSendProgress}) async {
    var result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.wifi && result != ConnectivityResult.mobile) return null;
    try {
      var response = (data != null)
          ? await createDioInstance().post(path, data: data, onSendProgress: onSendProgress)
          : await createDioInstance().post(path, onSendProgress: onSendProgress);
      return response.data;
    } on DioException catch (e) {
      return e.response?.data;
    }
  }

  static Future<Map<String, String>?> put(String path, Object? data) async {
    try {
      var response = await createDioInstance().put(path, data: data);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, String>?> delete(String path, Object? data) async {
    try {
      var response = await createDioInstance().delete(path, data: data);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
