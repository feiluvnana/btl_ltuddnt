import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/models/friend.dart';
import 'package:Anti_Fakebook/ui/Home/Friend/friend_all.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Friend/friend_suggested.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRequestedUI extends ConsumerStatefulWidget {
  const FriendRequestedUI({super.key});

  @override
  ConsumerState<FriendRequestedUI> createState() => _FriendUIState();
}

class _FriendUIState extends ConsumerState<FriendRequestedUI> {
  final ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent) {
        ref.read(friendControllerProvider.notifier).getRequestedFriends();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var requestedFriends =
        ref.watch(friendControllerProvider.select((value) => value.value?.requestedFriends));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FriendRequestedHeader(),
        Wrap(spacing: 8, children: [
          const SizedBox(width: 2),
          ChoiceChip(
              selected: false,
              onSelected: (_) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const FriendSuggestedUI())),
              label: const Text("Gợi ý")),
          ChoiceChip(
              selected: false,
              onSelected: (_) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const FriendAllUI())),
              label: const Text("Tất cả bạn bè"))
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: "Lời mời kết bạn  ",
                style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            TextSpan(
                text: ref
                    .watch(friendControllerProvider
                        .select((value) => value.value?.totalRequested ?? 0))
                    .toString(),
                style: themeData.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: themeData.colorScheme.error)),
          ])),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(friendControllerProvider.notifier).refreshRequestedFriends();
            },
            child: (requestedFriends == null)
                ? const Center(child: Text("Đang tải..."))
                : ListView.custom(
                    controller: ctrl,
                    physics: const AlwaysScrollableScrollPhysics(),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == requestedFriends.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: requestedFriends.length ==
                                        ref.read(friendControllerProvider).value?.totalRequested
                                    ? const Text("Đã hết lời mời kết bạn.")
                                    : const CircularProgressIndicator()),
                          );
                        }
                        return FriendRequestedItem(
                            key: ValueKey(requestedFriends[index].id),
                            friend: requestedFriends[index]);
                      },
                      childCount: requestedFriends.length + 1,
                      findChildIndexCallback: (key) {
                        var index = requestedFriends
                            .indexWhere((element) => element.id == (key as ValueKey<int>).value);
                        if (index == -1) return null;
                        return index;
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class FriendRequestedHeader extends StatelessWidget {
  const FriendRequestedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 10),
        Text("Bạn bè",
            style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: themeData.colorScheme.onInverseSurface, shape: BoxShape.circle),
            child: const Icon(Icons.search),
          ),
        )
      ],
    );
  }
}

class FriendRequestedItem extends ConsumerStatefulWidget {
  final Friend friend;

  const FriendRequestedItem({super.key, required this.friend});

  @override
  ConsumerState<FriendRequestedItem> createState() => _FriendRequestedItemState();
}

class _FriendRequestedItemState extends ConsumerState<FriendRequestedItem>
    with AutomaticKeepAliveClientMixin {
  var accepted = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 20,
        child: Row(
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
                  children: !accepted
                      ? [
                          Expanded(
                              child: AFBPrimaryEButton(
                                  onPressed: () {
                                    setState(() {
                                      accepted = true;
                                    });
                                    ref
                                        .read(friendControllerProvider.notifier)
                                        .setAcceptFriend(widget.friend.id, 1);
                                  },
                                  child: const Text("Chấp nhận"))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: AFBSecondaryEButton(
                                  onPressed: () {
                                    ref
                                        .read(friendControllerProvider.notifier)
                                        .setAcceptFriend(widget.friend.id, 0);
                                  },
                                  child: const Text("Xóa")))
                        ]
                      : [const Text("Các bạn đã là bạn bè!")],
                )
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
