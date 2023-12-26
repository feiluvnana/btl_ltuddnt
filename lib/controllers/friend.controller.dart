import 'dart:convert';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/main.dart';
import 'package:Anti_Fakebook/models/friend.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
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
      List<Friend>? allFriends,
      @Default(0) int totalAll,
      @Default(0) int totalRequested}) = _FriendState;
}

@Riverpod(keepAlive: true)
class FriendController extends _$FriendController {
  bool lockFetchSuggestedFriend = false;
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

  void refreshRequestedFriends() {
    state = AsyncValue.data(state.value!.copyWith(requestedFriends: null, totalRequested: 0));
    canFetchRequestedFriend = true;
    getRequestedFriends();
  }

  void refreshSuggestedFriends() {
    state = AsyncValue.data(state.value!.copyWith(suggestedFriends: null));
    canFetchSuggestedFriend = true;
    lockFetchSuggestedFriend = false;
    getSuggestedFriends();
  }

  void refreshAllFriends() {
    state = AsyncValue.data(state.value!.copyWith(allFriends: null, totalAll: 0));
    canFetchAllFriend = true;
    getAllFriends();
  }

  Future<void> getSuggestedFriends() async {
    if (!canFetchSuggestedFriend || lockFetchSuggestedFriend) return;
    canFetchSuggestedFriend = false;
    await Api().getSuggestedFriends(state.requireValue.suggestedFriends?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        if (value["data"].length < 15) {
          lockFetchSuggestedFriend = true;
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
        if (int.parse(value["data"]["total"]) <=
            ((state.requireValue.requestedFriends?.length ?? 0) +
                value["data"]["requests"].length)) {
          canFetchRequestedFriend = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(requestedFriends: [
          ...state.value?.requestedFriends ?? [],
          ...(value["data"]["requests"] as List).map((e) => Friend.fromJson(e))
        ], totalRequested: int.parse(value["data"]["total"])));
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
        if (int.parse(value["data"]["total"]) <=
            ((state.requireValue.allFriends?.length ?? 0) + value["data"]["friends"].length)) {
          canFetchAllFriend = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(allFriends: [
          ...state.value?.allFriends ?? [],
          ...(value["data"]["friends"] as List).map((e) => Friend.fromJson(e))
        ], totalAll: int.parse(value["data"]["total"])));
      }
    });
    canFetchAllFriend = !canFetchAllFriend;
  }

  Future<void> unfriend(int userId) async {
    await Api().unfriend(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.value!.copyWith(
            allFriends:
                state.value?.suggestedFriends?.where((element) => element.id != userId).toList(),
            totalAll: state.value!.totalAll - 1));
      }
    });
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

  Future<void> setAcceptFriend(int userId, int isAccept) async {
    if (isAccept == 0) {
      state = AsyncValue.data(state.value!.copyWith(
          requestedFriends:
              state.value?.requestedFriends?.where((element) => element.id != userId).toList(),
          totalRequested: state.value!.totalRequested - 1));
    }
    await Api().setAcceptFriend(userId, isAccept).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else if (isAccept == 1) {
        var friend = state.value!.requestedFriends!.firstWhere((element) => element.id == userId);
        state = AsyncValue.data(state.value!.copyWith(
            requestedFriends:
                state.value?.requestedFriends?.where((element) => element.id != userId).toList(),
            allFriends: [friend, ...state.value?.allFriends ?? []]));
      }
    });
  }

  void removeFriendFromAll(int id) {
    state = AsyncValue.data(state.value!.copyWith(
        allFriends: state.value!.allFriends!.where((element) => element.id != id).toList(),
        totalAll: state.value!.totalAll - 1));
  }

  Future<List<Friend>> getUserFriends(int userId) {
    return Api().getUserFriends(0, userId, 6).then((value) {
      if (value == null) {
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
      } else {
        return (value["data"]["friends"] as List).map((e) => Friend.fromJson(e)).toList();
      }
      return [];
    });
  }

  void reset() {
    state = const AsyncValue.data(FriendState());
  }
}
