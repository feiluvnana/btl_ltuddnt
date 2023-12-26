import 'package:Anti_Fakebook/controllers/authen.controller.dart';
import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/models/keyword.model.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search.controller.freezed.dart';
part 'search.controller.g.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({List<Post>? searchResult, List<Keyword>? keywords}) = _SearchState;
}

@Riverpod(keepAlive: true)
class SearchController extends _$SearchController {
  var canFetchBlockedUser = true;

  @override
  FutureOr<SearchState> build() async {
    return const SearchState();
  }

  void init() {
    Api().getSavedSearch().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.requireValue
            .copyWith(keywords: (value["data"] as List).map((e) => Keyword.fromJson(e)).toList()));
      }
    });
  }

  Future<void> search(String keyword) async {
    await Api()
        .search(
            keyword: keyword, userId: ref.read(authenControllerProvider).value!.user!.id, index: 0)
        .then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] == "9994") {
        state = AsyncValue.data(state.requireValue.copyWith(searchResult: []));
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.requireValue
            .copyWith(searchResult: (value["data"] as List).map((e) => Post.fromJson(e)).toList()));
      }
    });
    Api().getSavedSearch().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        state = AsyncValue.data(state.requireValue
            .copyWith(keywords: (value["data"] as List).map((e) => Keyword.fromJson(e)).toList()));
      }
    });
  }

  void deleteResult() {
    state = AsyncValue.data(state.requireValue.copyWith(searchResult: null));
  }

  void deleteSearch(int? id, [int all = 0]) {
    state = AsyncValue.data(state.requireValue.copyWith(
        keywords: state.requireValue.keywords?.where((element) => element.id != id).toList()));
    Api().delSavedSearch(searchId: id, all: all).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Xóa tìm kiếm thành công.");
      }
    });
  }

  void reset() {
    state = const AsyncValue.data(SearchState());
  }
}
