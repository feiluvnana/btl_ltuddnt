import 'dart:convert';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/user.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/enum.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authen_bloc.freezed.dart';

abstract class AuthenEvent {
  const AuthenEvent();
}

class AuthenLogin extends AuthenEvent {
  final String email, password;
  const AuthenLogin(this.email, this.password);
}

@freezed
class AuthenState with _$AuthenState {
  const factory AuthenState(
      {@Default(AuthenStatus.unauthenticated) AuthenStatus status,
      User? user}) = _AuthenState;
}

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  AuthenBloc() : super(const AuthenState()) {
    on<AuthenLogin>((event, emit) async {
      emit(state.copyWith(status: AuthenStatus.authenticating));
      var res = await Api.login(event.email, event.password);
      if (res["code"] != "1000") {
        emit(state.copyWith(status: AuthenStatus.unauthenticated));
      } else {
        await secureStorage.write(
            key: "token", value: jsonDecode(res["data"]!)["token"]);
        emit(state.copyWith(
            status: AuthenStatus.authenticated,
            user: User.fromJson(jsonDecode(res["data"] ?? ""))));
      }
    });
  }
}
