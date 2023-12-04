import 'dart:convert';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/extension.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/friend.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend.controller.freezed.dart';
part 'friend.controller.g.dart';

@freezed
class FriendState with _$FriendState {
  const factory FriendState(
      {List<Friend>? suggestedFriends,
      List<Friend>? requestedFriends,
      List<Friend>? allFriends}) = _FriendState;
}

@Riverpod(keepAlive: true)
class FriendController extends _$FriendController {
  bool canFetchSuggestedFriend = true;
  bool canFetchRequestedFriend = true;
  bool canFetchAllFriend = true;

  @override
  FutureOr<FriendState> build() {
    return const FriendState();
  }

  void init() {
    getSuggestedFriends();
    getRequestedFriends();
    getAllFriends();
  }

  Future<void> getSuggestedFriends() async {
    if (!canFetchSuggestedFriend) return;
    canFetchSuggestedFriend = false;
    await Api().getSuggestedFriends(state.requireValue.suggestedFriends?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy gợi ý kết bạn thành công.");
        if (value["data"].length < 15) {
          print("lock ${value["data"].length}");
          canFetchSuggestedFriend = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(suggestedFriends: [
          ...state.value?.suggestedFriends ?? [],
          ...(value["data"] as List).map((e) => Friend.fromJson(e))
        ]));
      }
    });
    canFetchSuggestedFriend = !canFetchSuggestedFriend;
  }

  Future<void> getRequestedFriends() async {
    if (!canFetchRequestedFriend) return;
    canFetchRequestedFriend = false;
    await Api().getRequestedFriends(state.requireValue.requestedFriends?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy gợi ý kết bạn thành công.");
        if (int.parse(value["data"]["total"]) <=
            ((state.requireValue.requestedFriends?.length ?? 0) +
                value["data"]["requests"].length)) {
          print("lock ");
          canFetchRequestedFriend = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(requestedFriends: [
          ...state.value?.requestedFriends ?? [],
          ...(value["data"]["requests"] as List).map((e) => Friend.fromJson(e))
        ]));
      }
    });
    canFetchRequestedFriend = !canFetchRequestedFriend;
  }

  Future<void> getAllFriends() async {
    if (!canFetchAllFriend) return;
    canFetchAllFriend = false;
    await Api()
        .getUserFriends(
            state.requireValue.allFriends?.length ?? 0,
            await secureStorage
                .read(key: "user")
                .then((value) => int.parse(jsonDecode(value!)["id"])))
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy gợi ý kết bạn thành công.");
        if (int.parse(value["data"]["total"]) <=
            ((state.requireValue.allFriends?.length ?? 0) + value["data"]["friends"].length)) {
          print("lock ");
          canFetchAllFriend = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(allFriends: [
          ...state.value?.allFriends ?? [],
          ...(value["data"]["friends"] as List).map((e) => Friend.fromJson(e))
        ]));
      }
    });
    canFetchAllFriend = !canFetchAllFriend;
  }

  Future<void> setRequestFriend(int userId) async {
    await Api().setRequestFriend(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.value!.copyWith(
          suggestedFriends:
              state.value?.suggestedFriends?.where((element) => element.id != userId).toList(),
        ));
        Fluttertoast.showToast(msg: "Gửi lời mời kết bạn thành công.");
      }
    });
  }

  Future<void> setAcceptFriend(int userId) async {
    await Api().setAcceptFriend(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.value!.copyWith(
          requestedFriends:
              state.value?.requestedFriends?.where((element) => element.id != userId).toList(),
        ));
        Fluttertoast.showToast(msg: "Đồng ý lời mời kết bạn thành công.");
      }
    });
  }

  void removeFriendFromAll(int id) {
    state = AsyncValue.data(state.value!.copyWith(
        allFriends: state.value!.allFriends!.where((element) => element.id != id).toList()));
  }

  void reset() {
    state = const AsyncValue.data(FriendState());
  }
}
