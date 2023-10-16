import 'package:btl_lap_trinh_ung_dung_da_nen_tang/data.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'newfeeds_bloc.freezed.dart';

abstract class NewfeedsEvent extends Equatable {
  const NewfeedsEvent();
}

@freezed
class NewfeedsState with _$NewfeedsState {
  const factory NewfeedsState({@Default([]) List<Post> posts}) = _NewfeedsState;
}

class NewfeedsBloc extends Bloc<NewfeedsEvent, NewfeedsState> {
  NewfeedsBloc()
      : super(NewfeedsState(
            posts: postData.map((e) => Post.fromJson(e)).toList())) {}
}
