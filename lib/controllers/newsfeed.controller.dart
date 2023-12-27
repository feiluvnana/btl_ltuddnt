import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/controllers/interface.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/main.dart';
import 'package:Anti_Fakebook/models/mark.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:crypto/crypto.dart';

part 'newsfeed.controller.freezed.dart';
part 'newsfeed.controller.g.dart';

@freezed
class NewsfeedState with _$NewsfeedState {
  const factory NewsfeedState(
      {List<Post>? posts, @Default({}) Map<String, double> postingProgress}) = _NewsfeedState;
}

@Riverpod(keepAlive: true)
class NewsfeedController extends _$NewsfeedController implements PostEditable, PostAddable {
  bool canFetch = true;
  int lastId = 0;

  @override
  FutureOr<NewsfeedState> build() async {
    List<Post>? posts;
    await secureStorage.read(key: "posts").then((value) {
      if (value != null) {
        posts = (jsonDecode(value) as List).map<Post>((e) => Post.fromJson(e)).toList();
      }
    });
    return NewsfeedState(posts: posts);
  }

  void refresh() {
    canFetch = true;
    lastId = 0;
    state = AsyncValue.data(state.requireValue.copyWith(posts: null));
    init();
  }

  Future<void> init() async {
    await Api()
        .getListPosts(inCampaign: 0, campaignId: 1, latitute: 1.0, longitute: 1.0, lastId: lastId)
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
        secureStorage.write(key: "posts", value: jsonEncode(value["data"]["post"]));
        state = AsyncValue.data(state.requireValue.copyWith(
            posts: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
  }

  @override
  Future<int?> addPost({List<File>? image, File? video, String? described, String? status}) async {
    String key = "add-${md5.convert(List.generate(5, (index) => Random().nextInt(382002)))}";
    Fluttertoast.showToast(msg: "Bài viết đang được tải lên. Hãy đợi trong giây lát.");
    return await Api()
        .addPost(
            image: image,
            video: video,
            described: described,
            status: status,
            onSendProgress: (current, total) {
              state = AsyncValue.data(state.value!.copyWith(
                  postingProgress: {...state.value!.postingProgress, key: current / total}));
            })
        .then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        var post = await getPost(int.parse(value["data"]["id"]));
        var tempPosts = state.value?.posts?.toList();
        var tempProgress = <String, double>{};
        tempProgress.addEntries(state.value?.postingProgress.entries ?? []);
        tempProgress.remove(key);
        state = AsyncValue.data(state.value!
            .copyWith(posts: [...post, ...(tempPosts ?? [])], postingProgress: tempProgress));
        Fluttertoast.showToast(msg: "Đăng bài viết thành công.");
        return int.parse(value["data"]["id"]);
      }
      return null;
    });
  }

  @override
  Future<int?> editPost(
      {required int id,
      List<File>? image,
      File? video,
      String? described,
      String? status,
      List<int>? imageDel,
      List<int>? imageSort}) async {
    Fluttertoast.showToast(msg: "Bài viết đang được tải lên. Hãy đợi trong giây lát.");
    return await Api()
        .editPost(
            image: image,
            video: video,
            described: described,
            status: status,
            id: id,
            imageDel: imageDel,
            imageSort: imageSort)
        .then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        var post = await getPost(int.parse(value["data"]["id"]));
        var temp = state.value?.posts?.toList();
        var index = temp?.indexWhere((element) => element.id == id);
        if (index != -1 && index != null) {
          temp?.replaceRange(index, index + 1, post);
          state = AsyncValue.data(state.value!.copyWith(posts: temp));
          Fluttertoast.showToast(msg: "Sửa bài viết thành công.");
        }
        return int.parse(value["data"]["id"]);
      }
      return null;
    });
  }

  Future<void> getPosts() async {
    if (!canFetch) return;
    state = const AsyncValue.loading();
    canFetch = false;
    await Api()
        .getListPosts(inCampaign: 0, campaignId: 1, latitute: 1.0, longitute: 1.0, lastId: lastId)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else if (value["data"]["post"].isNotEmpty) {
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

  Future<void> reportPost(
      {required int id, required String subject, required String detail}) async {
    await Api().reportPost(id, subject, detail).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Báo cáo bài viết thành công.");
      }
    });
  }

  Future<void> deletePost({required int id}) async {
    await Api().deletePost(id).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Xóa bài viết thành công.");
        state = AsyncValue.data(state.requireValue.copyWith(
            posts: state.requireValue.posts?.where((element) => element.id != id).toList()));
      }
    });
  }

  Future<void> feelPost({required Post post, required int type}) async {
    state = AsyncValue.data(state.value!.copyWith(
        posts: state.value!.posts
            ?.map((e) => e.id == post.id
                ? e.copyWith(
                    isFelt: type == 0 ? FeelType.dissapointed : FeelType.kudos,
                    feel: (e.isFelt != FeelType.none) ? e.feel : e.feel + 1)
                : e)
            .toList()));
    await Api().feel(post.id, type).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      }
    });
  }

  Future<List<Mark>?> getMarkComment(int id, int index) {
    return Api().getMarkComment(id, index, 10).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        return ((value["data"]) as List).map<Mark>((e) => Mark.fromJson(e)).toList();
      }
      return [];
    });
  }

  Future<List<Mark>> setMarkComment(int id, String content, {int? type, int? markId}) async {
    return Api()
        .setMarkComment(id: id, content: content, markId: markId, type: type)
        .then((value) async {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(
            msg: resCode[value["code"]] ?? value["message"] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Đã mark/bình luận thành công");
        var post = await getPost(id);
        var temp = state.value?.posts?.toList();
        var index = temp?.indexWhere((element) => element.id == id);
        if (index != -1 && index != null) {
          temp?.replaceRange(index, index + 1, post);
          state = AsyncValue.data(state.value!.copyWith(posts: temp));
        }
        if (markId != null) {
          return (value["data"] as List).map((e) => Mark.fromJson(e)).toList();
        }
      }
      return [];
    });
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

  void reset() {
    state = const AsyncValue.data(NewsfeedState());
  }
}
