import 'dart:async';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/friend.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/friend.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendSuggestedUI extends ConsumerStatefulWidget {
  const FriendSuggestedUI({super.key});

  @override
  ConsumerState<FriendSuggestedUI> createState() => _FriendSuggestedUIState();
}

class _FriendSuggestedUIState extends ConsumerState<FriendSuggestedUI> {
  final ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent) {
        ref.read(friendControllerProvider.notifier).getSuggestedFriends();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AFBAppBar(
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
              child: Builder(builder: (context) {
                var suggestedFriends = ref.watch(
                    friendControllerProvider.select((value) => value.value?.suggestedFriends));
                return ListView.custom(
                  controller: ctrl,
                  physics: const AlwaysScrollableScrollPhysics(),
                  childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FriendItem(
                            key: ValueKey<int>(suggestedFriends![index].id),
                            friend: suggestedFriends[index]);
                      },
                      childCount: suggestedFriends?.length ?? 0,
                      findChildIndexCallback: (key) {
                        var index = suggestedFriends
                            ?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
                        if (index == -1) return null;
                        return index;
                      }),
                );
              }),
            )
          ],
        ));
  }
}

class FriendItem extends ConsumerStatefulWidget {
  final Friend friend;

  const FriendItem({super.key, required this.friend});

  @override
  ConsumerState<FriendItem> createState() => _FriendItemState();
}

enum RequestState { available, cancellable, unavailable }

class _FriendItemState extends ConsumerState<FriendItem> with AutomaticKeepAliveClientMixin {
  var state = RequestState.available;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AFBCircleAvatar(imageUrl: widget.friend.avatar, radius: 70),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.friend.username, style: themeData.textTheme.titleMedium),
                if (widget.friend.sameFriends > 0)
                  Text("${widget.friend.sameFriends} bạn chung",
                      style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300)),
                Row(
                    children: switch (state) {
                  RequestState.available => [
                      Expanded(
                          child: AFBPrimaryEButton(
                              onPressed: () {
                                setState(() {
                                  state = RequestState.cancellable;
                                });
                                timer = Timer(const Duration(seconds: 2), () {
                                  setState(() {
                                    state = RequestState.unavailable;
                                  });
                                  ref
                                      .read(friendControllerProvider.notifier)
                                      .setRequestFriend(widget.friend.id);
                                });
                              },
                              child: const Text("Thêm bạn bè"))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: AFBSecondaryEButton(onPressed: () {}, child: const Text("Gỡ")))
                    ],
                  RequestState.cancellable => [
                      Expanded(
                        child: AFBSecondaryEButton(
                            onPressed: () {
                              timer?.cancel();
                              setState(() {
                                timer = null;
                                state = RequestState.available;
                              });
                            },
                            child: const Text("Hủy")),
                      ),
                    ],
                  RequestState.unavailable => [
                      const Expanded(
                          child:
                              AFBSecondaryEButton(onPressed: null, child: Text("Đã gửi lời mời"))),
                    ]
                })
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
