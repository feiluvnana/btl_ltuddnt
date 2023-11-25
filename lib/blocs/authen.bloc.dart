import 'dart:convert';
import 'dart:io';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/user.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authen.bloc.freezed.dart';

abstract class AuthenEvent {
  const AuthenEvent();
}

class AuthenSignupInfoChange extends AuthenEvent {
  final Map<String, String> info;

  const AuthenSignupInfoChange(this.info);
}

class AuthenSignupRequest extends AuthenEvent {
  final void Function() successCallback;
  final void Function()? finallyCallback;

  const AuthenSignupRequest(this.successCallback, [this.finallyCallback]);
}

class AuthenCheckVerifyCode extends AuthenEvent {
  final String code, email;
  final void Function() successCallback;
  final void Function()? finallyCallback;

  const AuthenCheckVerifyCode(this.email, this.code, this.successCallback, [this.finallyCallback]);
}

class AuthenGetVerifyCode extends AuthenEvent {
  final String? email;
  final void Function() successCallback;
  final void Function()? finallyCallback;

  const AuthenGetVerifyCode(this.email, this.successCallback, [this.finallyCallback]);
}

class AuthenChangeProfileAfter extends AuthenEvent {
  final String username;
  final File? avatar;
  final void Function() successCallback;
  final void Function()? finallyCallback;

  const AuthenChangeProfileAfter(this.username, this.avatar, this.successCallback,
      [this.finallyCallback]);
}

class AuthenLogin extends AuthenEvent {
  final String email, password;
  final void Function(int?) successCallback;
  final void Function()? finallyCallback;
  const AuthenLogin(this.email, this.password, this.successCallback, [this.finallyCallback]);
}

class AuthenChangePassword extends AuthenEvent {
  final String password, newPassword;
  final void Function() successCallback;
  final void Function()? finallyCallback;
  const AuthenChangePassword(this.password, this.newPassword, this.successCallback,
      [this.finallyCallback]);
}

class AuthenLogout extends AuthenEvent {
  const AuthenLogout();
}

class AuthenResetPassword extends AuthenEvent {
  final String password, code, email;
  final void Function() successCallback;
  final void Function()? finallyCallback;
  const AuthenResetPassword(
      {required this.password,
      required this.code,
      required this.email,
      required this.successCallback,
      this.finallyCallback});
}

@freezed
class AuthenState with _$AuthenState {
  const factory AuthenState({@Default({}) Map<String, String> signupInfo, User? user}) =
      _AuthenState;
}

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthenBloc([User? user]) : super(AuthenState(user: user)) {
    on<AuthenLogin>((event, emit) async {
      await Api().login(event.email, event.password).then((value) async {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định");
          event.successCallback(null);
        } else {
          Fluttertoast.showToast(msg: "Đăng nhập thành công");
          await secureStorage.write(
              key: "user", value: jsonEncode({...value["data"], "email": event.email}));
          emit(state.copyWith(user: User.fromJson({...value["data"], "email": event.email})));
          event.successCallback(state.user?.active);
        }
      });
      event.finallyCallback?.call();
    });
    on<AuthenChangePassword>((event, emit) async {
      await Api().changePassword(event.password, event.newPassword).then((value) async {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đổi mật khẩu thành công.");
          await secureStorage.read(key: "user").then((user) async {
            if (user == null) return;
            emit(state.copyWith(user: state.user?.copyWith(token: value["data"]["token"])));
            await secureStorage.write(
                key: "user",
                value: jsonEncode(state.user?.copyWith(token: value["data"]["token"]).toJson()));
          });
          event.successCallback();
        }
      });
      event.finallyCallback?.call();
    });
    on<AuthenResetPassword>((event, emit) async {
      await Api().resetPassword(event.email, event.code, event.password).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đặt lại mật khẩu thành công.");
          event.successCallback();
        }
      });
      event.finallyCallback?.call();
    });
    on<AuthenLogout>((event, emit) {
      Api().logout().then((value) {
        secureStorage.delete(key: "posts");
        secureStorage.write(
            key: "user", value: jsonEncode(state.user?.copyWith(token: null).toJson()));
      });
      emit(state.copyWith(user: state.user?.copyWith(token: null), signupInfo: {}));
    });
    on<AuthenGetVerifyCode>(((event, emit) async {
      await Api().getVerifyCode(event.email ?? state.user!.email!).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đã gửi mã xác nhận thành công");
          event.successCallback();
        }
      });
      event.finallyCallback?.call();
    }));
    on<AuthenSignupRequest>((event, emit) async {
      await Api().signup(state.signupInfo["email"]!, state.signupInfo["password"]!).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đăng ký thành công");
          event.successCallback();
        }
      });
      event.finallyCallback?.call();
    });
    on<AuthenSignupInfoChange>((event, emit) {
      emit(state.copyWith(signupInfo: event.info));
    });
    on<AuthenCheckVerifyCode>((event, emit) async {
      await Api().checkVerifyCode(event.email, event.code).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Xác nhận thành công");
          emit(state.copyWith(
              user: state.user?.copyWith(active: int.parse(value["data"]["active"]))));
          event.successCallback();
        }
      });
      emit(state.copyWith(signupInfo: {}));
      event.finallyCallback?.call();
    });
    on<AuthenChangeProfileAfter>((event, emit) async {
      await Api().changeProfileAfterSignup(event.username, event.avatar).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đã cập nhật thông tin thành công");
          emit(state.copyWith(
              user: state.user?.copyWith(
                  username: value["data"]["username"], avatar: value["data"]["username"])));
          event.successCallback();
        }
      });
      event.finallyCallback?.call();
    });
  }
}
