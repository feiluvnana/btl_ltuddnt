import 'dart:convert';
import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'newsfeed_bloc.freezed.dart';

abstract class NewsfeedEvent {
  const NewsfeedEvent();
}

class NewsfeedPostRefresh extends NewsfeedEvent {
  const NewsfeedPostRefresh();
}

class NewsfeedAddPost extends NewsfeedEvent {
  final String? described, status;
  final List<File>? image;
  final File? video;

  const NewsfeedAddPost({this.described, this.status, this.image, this.video});
}

class NewsfeedReportPost extends NewsfeedEvent {
  final int id;
  final String subject, detail;

  NewsfeedReportPost({required this.id, required this.subject, required this.detail});
}

class NewsfeedDeletePost extends NewsfeedEvent {
  final int id;

  NewsfeedDeletePost({required this.id});
}

class NewsfeedInit extends NewsfeedEvent {
  const NewsfeedInit();
}

@freezed
class NewsfeedState with _$NewsfeedState {
  const factory NewsfeedState({List<Post>? posts}) = _NewsfeedState;
}

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  NewsfeedBloc() : super(const NewsfeedState()) {
    on<NewsfeedPostRefresh>((event, emit) async {
      emit(state.copyWith(posts: null));
      add(const NewsfeedInit());
    });
    on<NewsfeedAddPost>((event, emit) async {
      Fluttertoast.showToast(msg: "Bài viết đang được tải lên. Hãy đợi trong giây lát.");
      await Api()
          .addPost(
              image: event.image,
              video: event.video,
              described: event.described,
              status: event.status)
          .then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Đăng bài viết thành công.");
        }
      });
      ;
    });
    on<NewsfeedInit>((event, emit) async {
      await Api()
          .getListPosts(
              userId: await secureStorage
                  .read(key: "user")
                  .then((value) => int.parse(jsonDecode(value ?? "{}")["id"])),
              inCampaign: 0,
              campaignId: 1,
              latitute: 1.0,
              longitute: 1.0,
              lastId: 0,
              index: 0,
              count: 10)
          .then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Lấy bài viết thành công.");
          emit(state.copyWith(
              posts: (value["data"]["post"] as List).map((e) => Post.fromJson(e)).toList()));
        }
      });
    });
    on<NewsfeedReportPost>((event, emit) async {
      await Api().reportPost(event.id, event.subject, event.detail).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Báo cáo bài viết thành công.");
        }
      });
    });
    on<NewsfeedDeletePost>((event, emit) async {
      await Api().deletePost(event.id).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Xóa bài viết thành công.");
          emit(state.copyWith(
              posts: state.posts?.where((element) => element.id != event.id).toList()));
        }
      });
    });
  }
}
