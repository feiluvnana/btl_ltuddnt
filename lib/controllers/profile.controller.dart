import 'dart:io';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/models/profile.model.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "profile.controller.freezed.dart";
part "profile.controller.g.dart";

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({Profile? profile, List<Post>? posts}) = _ProfileState;
}

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  bool canFetch = true;
  int lastId = 0;

  @override
  FutureOr<ProfileState> build() async {
    return const ProfileState();
  }

  void refresh() {
    canFetch = true;
    lastId = 0;
    state = AsyncValue.data(state.requireValue.copyWith(posts: null));
    init();
  }

  Future<void> init() async {
    int userId = 0;
    await Api().getUserInfo(null).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        userId = Profile.fromJson(value["data"]).id;
        state =
            AsyncValue.data(state.requireValue.copyWith(profile: Profile.fromJson(value["data"])));
      }
    });
    await Api()
        .getListPosts(latitute: 1.0, longitute: 1.0, userId: userId, lastId: lastId)
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
        state = AsyncValue.data(state.requireValue.copyWith(
            posts: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
  }

  Future<void> getPosts() async {
    if (!canFetch) return;
    state = const AsyncValue.loading();
    canFetch = false;
    await Api()
        .getListPosts(
            userId: state.value!.profile!.id, latitute: 1.0, longitute: 1.0, lastId: lastId)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else if (value["data"]["post"].isNotEmpty) {
        if (value["data"]["post"].isEmpty) {
          canFetch = true;
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

  Future<Profile?> getUserInfo(int? userId) {
    return Api().getUserInfo(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] == "3001") {
        Fluttertoast.showToast(msg: "Người dùng này đã bị chặn.");
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        return Profile.fromJson(value["data"]);
      }
      return null;
    });
  }

  Future<void> setUserInfo(
      {String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      File? coverImage,
      File? avatar,
      String? link}) async {
    state = AsyncValue.data(state.value!.copyWith.profile!.call(
        username: username ?? state.value!.profile!.username,
        description: description ?? state.value!.profile!.description,
        address: address ?? state.value!.profile!.address));
    await Api()
        .setUserInfo(
            username: username,
            description: description,
            address: address,
            city: city,
            country: country,
            coverImage: coverImage,
            avatar: avatar,
            link: link)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        return;
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
        return;
      } else {
        state = AsyncValue.data(state.value!.copyWith.profile!.call(
            avatar: value["data"]["avatar"],
            coverImage: value["data"]["cover_image"],
            link: value["data"]["link"],
            city: value["data"]["city"],
            country: value["data"]["country"]));
      }
    });
  }

  void reset() {
    state = const AsyncValue.data(ProfileState());
  }

  Future<List<Post>> getPost(int id) {
    return Api().getPost(id).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        return [];
      } else if (value["code"] == "9998") {
        ref.reset();
        return [];
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
        return [];
      }
      return [Post.fromJson(value["data"])];
    });
  }

  void deletePost({required int id}) {
    state = AsyncValue.data(state.requireValue
        .copyWith(posts: state.requireValue.posts?.where((element) => element.id != id).toList()));
  }

  void addPost(int id) {
    var post =
        ref.read(newsfeedControllerProvider).value!.posts!.where((element) => element.id == id);
    if (post.first.author.id != state.value!.profile!.id) return;
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

  void unfeelPost({required Post post}) {
    state = AsyncValue.data(state.value!.copyWith(
        posts: state.value!.posts
            ?.map((e) => e.id == post.id ? e.copyWith(isFelt: FeelType.none, feel: e.feel - 1) : e)
            .toList()));
  }

  Future<void> buyCoins() async {
    await Api().buyCoin().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.value!
            .copyWith(profile: state.value!.profile?.copyWith(coins: value["data"]["coins"])));
      }
    });
  }
}
