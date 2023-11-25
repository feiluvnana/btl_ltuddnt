import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/friend.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/response_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.bloc.freezed.dart';

abstract class FriendEvent {
  const FriendEvent();
}

class FriendGetSuggested extends FriendEvent {
  const FriendGetSuggested();
}

class FriendGetRequested extends FriendEvent {
  const FriendGetRequested();
}

class FriendGetAll extends FriendEvent {
  const FriendGetAll();
}

class FriendInit extends FriendEvent {
  const FriendInit();
}

class FriendReset extends FriendEvent {
  const FriendReset();
}

@freezed
class FriendState with _$FriendState {
  const factory FriendState(
      {List<Friend>? suggestedFriends,
      List<Friend>? requestedFriends,
      List<Friend>? allFriends}) = _FriendState;
}

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc() : super(const FriendState()) {
    on<FriendGetSuggested>((event, emit) async {
      await Api().getSuggestedFriends(state.suggestedFriends?.length ?? 0).then((value) {
        if (value == null) {
          Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
        } else if (value["code"] != "1000") {
          Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
        } else {
          Fluttertoast.showToast(msg: "Lấy gợi ý kết bạn thành công.");
          emit(state.copyWith(
              suggestedFriends: (value["data"] as List).map((e) => Friend.fromJson(e)).toList()));
        }
      });
    });
    on<FriendReset>((event, emit) =>
        emit(state.copyWith(allFriends: null, suggestedFriends: null, requestedFriends: null)));
    on<FriendInit>((event, emit) {
      add(const FriendGetSuggested());
    });
  }
}
