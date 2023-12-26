import 'dart:async';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/models/blockeduser.model.dart';
import 'package:Anti_Fakebook/models/notisettings.model.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.controller.freezed.dart';
part 'settings.controller.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({NotiSettings? notiSettings, List<BlockedUser>? blockedUsers}) =
      _SettingsState;
}

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  var canFetchBlockedUser = true;

  @override
  FutureOr<SettingsState> build() async {
    return const SettingsState();
  }

  Future<void> init() async {
    Api().setDevToken().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      }
    });
    Api().getPushSettings().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(
            state.value!.copyWith(notiSettings: NotiSettings.fromJson(value["data"])));
      }
    }).onError((error, stackTrace) {
      state = AsyncError(error ?? Object(), stackTrace);
    });
    Api().getListBlocks(state.value?.blockedUsers?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.value!.copyWith(
            blockedUsers: (value["data"] as List).map((e) => BlockedUser.fromJson(e)).toList()));
      }
    }).onError((error, stackTrace) {
      state = AsyncError(error ?? Object(), stackTrace);
    });
  }

  Future<void> setPushSettings(NotiSettings notiSettings) async {
    state = AsyncValue.data(state.value!.copyWith(notiSettings: notiSettings));
    Api().setPushSettings(notiSettings).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Sửa thông tin cài đặt thông báo thành công.");
      }
    });
  }

  Future<void> setBlock(int userId, String name, String avatar) async {
    state = AsyncValue.data(state.value!.copyWith(
        blockedUsers: [...state.value?.blockedUsers ?? [], BlockedUser(userId, name, avatar)]));
    Api().setBlock(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Chặn người dùng thành công.");
      }
    });
  }

  void reset() {
    state = const AsyncValue.data(SettingsState());
  }
}
