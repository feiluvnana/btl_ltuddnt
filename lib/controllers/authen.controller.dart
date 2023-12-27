import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/controllers/notification.controller.dart';
import 'package:Anti_Fakebook/main.dart';
import 'package:Anti_Fakebook/models/user.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authen.controller.freezed.dart';
part 'authen.controller.g.dart';

@freezed
class AuthenState with _$AuthenState {
  const factory AuthenState({@Default({}) Map<String, String> signupInfo, User? user}) =
      _AuthenState;
}

@Riverpod(keepAlive: true)
class AuthenController extends _$AuthenController {
  @override
  FutureOr<AuthenState> build() async {
    User? user;
    await secureStorage.read(key: "user").then((value) {
      if (value != null) {
        user = User.fromJson(jsonDecode(value));
      }
    });
    return AuthenState(user: user);
  }

  Future<int?> login({required String email, required String password}) async {
    return await Api().login(email, password).then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định");
        return null;
      } else {
        Fluttertoast.showToast(msg: "Đăng nhập thành công");
        await secureStorage.write(
            key: "user", value: jsonEncode({...value["data"], "email": email}));
        state = AsyncValue.data(
            state.requireValue.copyWith(user: User.fromJson({...value["data"], "email": email})));
        return state.value?.user?.active;
      }
    }).onError((error, stackTrace) => null);
  }

  Future<void> changePassword(
      {required String password,
      required String newPassword,
      required void Function()? onSuccess}) async {
    await Api().changePassword(password, newPassword).then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đổi mật khẩu thành công.");
        await secureStorage.read(key: "user").then((user) async {
          if (user == null) return;
          await secureStorage.write(
              key: "user",
              value: jsonEncode(
                  state.requireValue.user?.copyWith(token: value["data"]["token"]).toJson()));
        });
        onSuccess?.call();
        state = AsyncValue.data(state.requireValue
            .copyWith(user: state.requireValue.user?.copyWith(token: value["data"]["token"])));
      }
    });
  }

  void logout() {
    state = AsyncValue.data(state.requireValue
        .copyWith(user: state.requireValue.user?.copyWith(token: null), signupInfo: {}));
    secureStorage.delete(key: "posts");
    secureStorage.read(key: "saveInfo").then((value) {
      if (value == "true") {
        secureStorage.write(
            key: "user",
            value: jsonEncode(state.requireValue.user?.copyWith(token: null).toJson()));
      } else {
        secureStorage.delete(key: "user");
      }
    });
    Api().logout();
    ref.read(notificationControllerProvider.notifier).subOnMessage?.cancel();
  }

  Future<void> getVerifyCode({String? email, void Function()? onSuccess}) async {
    await Api().getVerifyCode(email ?? state.requireValue.user!.email!).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đã gửi mã xác nhận thành công");
        onSuccess?.call();
      }
    });
  }

  void updateSignupInfo({required Map<String, String> info}) {
    state = AsyncValue.data(state.requireValue.copyWith(signupInfo: info));
  }

  Future<void> checkVerifyCode(
      {required String email, required String code, void Function()? onSuccess}) async {
    await Api().checkVerifyCode(email, code).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Xác nhận thành công");
        state = AsyncValue.data(state.requireValue.copyWith(
            user: state.requireValue.user?.copyWith(active: int.parse(value["data"]["active"]))));
      }
    });
    state = AsyncValue.data(state.requireValue.copyWith(signupInfo: {}));
  }

  Future<void> changeProfileAfterSignup(
      {required String username, File? avatar, void Function()? onSuccess}) async {
    await Api().changeProfileAfterSignup(username, avatar).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đã cập nhật thông tin thành công");
        state = AsyncValue.data(state.requireValue.copyWith(
            user: state.requireValue.user?.copyWith(
                username: value["data"]["username"], avatar: value["data"]["username"])));

        onSuccess?.call();
      }
    });
  }

  Future<void> signup({void Function()? onSuccess}) async {
    if (state.requireValue.signupInfo["saveInfo"] == "true") {
      secureStorage.write(key: "saveInfo", value: "true");
    } else {
      secureStorage.write(key: "saveInfo", value: "false");
    }
    await Api()
        .signup(state.requireValue.signupInfo["email"]!, state.requireValue.signupInfo["password"]!)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đăng ký thành công");
        onSuccess?.call();
      }
    });
  }

  Future<void> resetPassword(
      {required String email,
      required String code,
      required String password,
      void Function()? onSuccess}) async {
    await Api().resetPassword(email, code, password).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đặt lại mật khẩu thành công.");
        onSuccess?.call();
      }
    });
  }

  Future<String?> checkEmail() async {
    return Api().checkEmail(state.value!.signupInfo["email"]!).then((value) {
      if (value == null) {
        return "Có lỗi xảy ra. Hãy thử lại sau";
      } else if (value["code"] != "1000") {
        return resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.";
      } else {
        return value["data"]["existed"] == "1" ? "Email đã được đăng ký" : null;
      }
    });
  }

  void deleteAccount() {
    state = AsyncValue.data(state.value!.copyWith(user: null));
    secureStorage.delete(key: "user");
  }
}
