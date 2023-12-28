import 'dart:convert';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/main.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch.controller.freezed.dart';
part 'watch.controller.g.dart';

@freezed
class WatchState with _$WatchState {
  const factory WatchState({List<Post>? posts}) = _WatchState;
}

@Riverpod(keepAlive: true)
class WatchController extends _$WatchController {
  bool canFetch = true;
  int lastId = 0;

  @override
  FutureOr<WatchState> build() async {
    return const WatchState();
  }

  void refresh() {
    canFetch = true;
    lastId = 0;
    state = AsyncValue.data(state.requireValue.copyWith(posts: null));
    init();
  }

  Future<void> init() async {
    await Api()
        .getListVideos(inCampaign: 0, campaignId: 1, latitute: 1.0, longitute: 1.0, lastId: lastId)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        lastId = int.parse(value["data"]["last_id"]);
        Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
        secureStorage.write(key: "posts", value: jsonEncode(value["data"]["post"]));
        state = AsyncValue.data(state.requireValue.copyWith(
            posts: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
  }

  Future<void> getVideos() async {
    if (!canFetch) return;
    state = const AsyncValue.loading();
    canFetch = false;
    await Api()
        .getListVideos(inCampaign: 0, campaignId: 1, latitute: 1.0, longitute: 1.0, lastId: lastId)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else if (value["data"]["post"].isNotEmpty) {
        Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
        if (value["data"]["new_items"].toString() == "0") {
          canFetch = true;
          debugPrint("locked fetch ${value["data"]["post"].length}");
        }
        lastId = int.parse(value["data"]["last_id"]);
        state = AsyncValue.data(state.value!.copyWith(posts: [
          ...state.value?.posts ?? [],
          ...(value["data"]["post"] as List).map((e) => Post.fromJson(e))
        ]));
      }
    });
    canFetch = !canFetch;
  }

  void deletePost({required int id}) {
    state = AsyncValue.data(state.requireValue
        .copyWith(posts: state.requireValue.posts?.where((element) => element.id != id).toList()));
  }

  void addPost(int id) {
    var post =
        ref.read(newsfeedControllerProvider).value!.posts!.where((element) => element.id == id);
    if (post.first.video == null) return;
    var tempPosts = state.value?.posts?.toList();
    state = AsyncValue.data(state.value!.copyWith(posts: [...post, ...(tempPosts ?? [])]));
  }

  void editPost(int id) {
    var post =
        ref.read(newsfeedControllerProvider).value!.posts!.where((element) => element.id == id);
    var temp = state.value?.posts?.toList();
    var index = temp?.indexWhere((element) => element.id == id);
    if (index != -1 && index != null) {
      temp?.replaceRange(index, index + 1, post);
      state = AsyncValue.data(state.value!.copyWith(posts: temp));
    }
  }

  void unfeelPost({required Post post}) {
    state = AsyncValue.data(state.value!.copyWith(
        posts: state.value!.posts
            ?.map((e) => e.id == post.id ? e.copyWith(isFelt: FeelType.none, feel: e.feel - 1) : e)
            .toList()));
  }

  void feelPost({required Post post, required int type}) {
    state = AsyncValue.data(state.value!.copyWith(
        posts: state.value!.posts
            ?.map((e) => e.id == post.id
                ? e.copyWith(
                    isFelt: type == 0 ? FeelType.dissapointed : FeelType.kudos,
                    feel: (e.isFelt != FeelType.none) ? e.feel : e.feel + 1)
                : e)
            .toList()));
  }
}
