import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/friend.bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/friend.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendSuggestedUI extends StatelessWidget {
  const FriendSuggestedUI({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: TransparentAppBar(
          title: Text("Gợi ý", style: themeData.textTheme.titleMedium),
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Những người bạn có thể biết",
                  style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: BlocBuilder<FriendBloc, FriendState>(builder: (context, state) {
                //TODO: remove this in the future
                var filteredSuggestedFriends =
                    state.suggestedFriends?.where((element) => element.username != "").toList();
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      FriendItem(friend: filteredSuggestedFriends![index]),
                  itemCount: filteredSuggestedFriends?.length ?? 0,
                );
              }),
            )
          ],
        ));
  }
}

class FriendItem extends StatelessWidget {
  final Friend friend;

  const FriendItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 80,
        width: MediaQuery.sizeOf(context).width - 20,
        child: Row(
          children: [
            AFBCircleAvatar(imageUrl: friend.avatar, radius: 70),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(friend.username, style: themeData.textTheme.titleMedium),
                if (friend.sameFriends > 0)
                  Text("${friend.sameFriends} bạn chung",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300)),
                Row(children: [
                  Expanded(
                      child: AFBPrimaryEButton(onPressed: () {}, child: const Text("Thêm bạn bè"))),
                  const SizedBox(width: 10),
                  Expanded(child: AFBSecondaryEButton(onPressed: () {}, child: const Text("Gỡ")))
                ])
              ],
            ))
          ],
        ),
      ),
    );
  }
}
