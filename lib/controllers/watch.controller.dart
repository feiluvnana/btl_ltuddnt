import 'dart:convert';
import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/extension.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch.controller.freezed.dart';
part 'watch.controller.g.dart';

@freezed
class WatchState with _$WatchState {
  const factory WatchState({List<Post>? videos}) = _WatchState;
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
    state = AsyncValue.data(state.requireValue.copyWith(videos: null));
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
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        lastId = int.parse(value["data"]["last_id"]);
        Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
        secureStorage.write(key: "videos", value: jsonEncode(value["data"]["post"]));
        state = AsyncValue.data(state.requireValue.copyWith(
            videos: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
  }

  Future<void> editVideo(
      {required int id,
      List<File>? image,
      File? video,
      String? described,
      String? status,
      List<int>? imageDel,
      List<int>? imageSort}) async {
    Fluttertoast.showToast(msg: "Bài viết đang được tải lên. Hãy đợi trong giây lát.");
    await Api()
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
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        await Api().getPost(int.parse(value["data"]["id"])).then((value) {
          if (value == null) {
            Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
          } else if (value["code"] == "9998") {
            ref.reset();
          } else if (value["code"] != "1000") {
            Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
          } else {
            var temp = state.value?.videos?.toList();
            var index = temp?.indexWhere((element) => element.id == id);
            if (index != -1 && index != null) {
              temp?.replaceRange(index, index + 1, [Post.fromJson(value["data"])]);
              state = AsyncValue.data(state.value!.copyWith(videos: temp));
              Fluttertoast.showToast(msg: "Sửa bài viết thành công.");
            }
          }
        });
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
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else if (value["data"]["post"].isNotEmpty) {
        Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
        if (value["data"]["new_items"].toString() == "0") {
          canFetch = true;
          debugPrint("locked fetch ${value["data"]["post"].length}");
        }
        lastId = int.parse(value["data"]["last_id"]);
        state = AsyncValue.data(state.value!.copyWith(videos: [
          ...state.value?.videos ?? [],
          ...(value["data"]["post"] as List).map((e) => Post.fromJson(e))
        ]));
      }
    });
    canFetch = !canFetch;
  }

  Future<void> reportVideo(
      {required int id, required String subject, required String detail}) async {
    await Api().reportPost(id, subject, detail).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Báo cáo bài viết thành công.");
      }
    });
  }

  Future<void> deleteVideo({required int id}) async {
    await Api().deletePost(id).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Xóa bài viết thành công.");
        state = AsyncValue.data(state.requireValue.copyWith(
            videos: state.requireValue.videos?.where((element) => element.id != id).toList()));
      }
    });
  }

  Future<void> feelVideo({required Post post, required int type}) async {
    if (post.isFelt == FeelType.none) {
      state = AsyncValue.data(state.value!.copyWith(
          videos: state.value!.videos
              ?.map((e) => e.id == post.id ? e.copyWith(feel: (e.feel ?? 0) + 1) : e)
              .toList()));
    }
    await Api().feel(post.id, type).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      }
    });
  }

  void reset() {
    state = const AsyncValue.data(WatchState());
  }
}
