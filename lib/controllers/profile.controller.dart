import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/extension.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/profile.model.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
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
  @override
  FutureOr<ProfileState> build() async {
    return const ProfileState();
  }

  Future<void> init() async {
    int userId = 0;
    await Api().getUserInfo(null).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy thông tin người dùng thành công.");
        userId = Profile.fromJson(value["data"]).id;
        state =
            AsyncValue.data(state.requireValue.copyWith(profile: Profile.fromJson(value["data"])));
      }
    });
    await Api()
        .getListPosts(latitute: 1.0, longitute: 1.0, userId: userId, lastId: 0)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
        state = AsyncValue.data(state.requireValue.copyWith(
            posts: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
  }

  Future<Profile?> getUserInfo(int? userId) {
    return Api().getUserInfo(userId).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        return null;
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        return null;
      } else {
        return Profile.fromJson(value["data"]);
      }
      return null;
    });
  }

  void reset() {
    state = const AsyncValue.data(ProfileState());
  }
}
