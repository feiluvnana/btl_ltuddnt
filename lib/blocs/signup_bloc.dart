import 'dart:io';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/enum.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'signup_bloc.freezed.dart';

abstract class SignupEvent {
  const SignupEvent();
}

// class SignupNameChange extends SignupEvent {
//   final String? firstName, lastName;

//   const SignupNameChange({this.firstName, this.lastName});
// }

// class SignupDobChange extends SignupEvent {
//   final DateTime dob;
//   const SignupDobChange({required this.dob});
// }

class SignupEmailChange extends SignupEvent {
  final String? email;
  const SignupEmailChange({required this.email});
}

class SignupPasswordChange extends SignupEvent {
  final String? password;
  const SignupPasswordChange({required this.password});
}

class SignupSaveInfoChange extends SignupEvent {
  final bool saveInfo;
  const SignupSaveInfoChange({required this.saveInfo});
}

class SignupRequest extends SignupEvent {
  final void Function() callback;

  const SignupRequest(this.callback);
}

class SignupCheckVerifyCode extends SignupEvent {
  final String code;
  final void Function() callback;

  const SignupCheckVerifyCode(this.code, this.callback);
}

class SignupGetVerifyCode extends SignupEvent {
  final void Function() callback;

  const SignupGetVerifyCode(this.callback);
}

class SignupChangeProfileAfter extends SignupEvent {
  final String username;
  final File? avatar;
  final void Function() callback;

  const SignupChangeProfileAfter(this.username, this.avatar, this.callback);
}

@freezed
class SignupState with _$SignupState {
  const factory SignupState(
      {/*@Default("") String firstName,
      @Default("") String lastName,
      required DateTime dob,*/
      @Default("") String email,
      @Default("") String password,
      @Default(false) bool saveInfo,
      @Default(SignupStatus.filling) SignupStatus status}) = _SignupState;
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    // on<SignupNameChange>((event, emit) {
    //   emit(state.copyWith(
    //       firstName: event.firstName ?? state.firstName,
    //       lastName: event.lastName ?? state.lastName));
    // });
    // on<SignupDobChange>((event, emit) {
    //   emit(state.copyWith(dob: event.dob));
    // });
    on<SignupEmailChange>((event, emit) {
      emit(state.copyWith(email: event.email ?? state.email));
    });
    on<SignupPasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password ?? state.password));
    });
    on<SignupSaveInfoChange>((event, emit) {
      emit(state.copyWith(saveInfo: event.saveInfo));
    });
    on<SignupRequest>((event, emit) async {
      emit(state.copyWith(status: SignupStatus.submitting));
      await Api().signup(state.email, state.password).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
          event.callback();
        } else {
          Fluttertoast.showToast(msg: "Đăng ký thành công");
          emit(state.copyWith(status: SignupStatus.validating));
          event.callback();
        }
      });
    });
    on<SignupCheckVerifyCode>((event, emit) async {
      await Api().checkVerifyCode(state.email, event.code).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Xác nhận thành công");
          event.callback();
        }
      });
    });
    on<SignupGetVerifyCode>((event, emit) async {
      await Api().getVerifyCode(state.email).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đã gửi lại mã xác nhận thành công");
          event.callback();
        }
      });
    });
    on<SignupChangeProfileAfter>((event, emit) async {
      await Api().changeProfileAfterSignup(event.username, event.avatar).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
          event.callback();
        } else {
          Fluttertoast.showToast(msg: "Đã cập nhật thông tin thành công");
          event.callback();
        }
      });
    });
  }
}
