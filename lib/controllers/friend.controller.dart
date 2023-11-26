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
  @override
  FutureOr<FriendState> build() {
    return const FriendState();
  }

  Future<void> getSuggestedFriends() async {
    await Api().getSuggestedFriends(state.requireValue.suggestedFriends?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        Fluttertoast.showToast(msg: "Lấy gợi ý kết bạn thành công.");
        state = AsyncValue.data(state.requireValue.copyWith(
            suggestedFriends: (value["data"] as List).map((e) => Friend.fromJson(e)).toList()));
      }
    });
  }

  void reset() {
    state = const AsyncValue.data(FriendState());
  }
}
