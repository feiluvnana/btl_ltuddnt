import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'newsfeed_bloc.freezed.dart';

abstract class NewsfeedEvent {
  const NewsfeedEvent();
}

class NewsfeedPostRefresh extends NewsfeedEvent {
  const NewsfeedPostRefresh();
}

@freezed
class NewsfeedState with _$NewsfeedState {
  const factory NewsfeedState({@Default([]) List<Post> posts}) = _NewsfeedState;
}

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  NewsfeedBloc() : super(const NewsfeedState(posts: [])) {
    on<NewsfeedPostRefresh>((event, emit) async {
      var temp = state.posts;
      emit(state.copyWith(posts: []));
      await Future.delayed(const Duration(seconds: 1), () {});
      emit(state.copyWith(posts: temp));
    });
  }
}
