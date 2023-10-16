import 'package:btl_lap_trinh_ung_dung_da_nen_tang/data.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'newsfeed_bloc.freezed.dart';

abstract class NewsfeedEvent {
  const NewsfeedEvent();
}

@freezed
class NewsfeedState with _$NewsfeedState {
  const factory NewsfeedState({@Default([]) List<Post> posts}) = _NewsfeedState;
}

class NewsfeedBloc extends Bloc<NewsfeedEvent, NewsfeedState> {
  NewsfeedBloc()
      : super(NewsfeedState(
            posts: postData.map((e) => Post.fromJson(e)).toList()));
}
