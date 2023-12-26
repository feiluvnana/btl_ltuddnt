import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/controllers/settings.controller.dart';
import 'package:Anti_Fakebook/models/friend.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SortType { normal, ascending, descending }

class FriendAllUI extends ConsumerStatefulWidget {
  const FriendAllUI({super.key});

  @override
  ConsumerState<FriendAllUI> createState() => _FriendSuggestedUIState();
}

class _FriendSuggestedUIState extends ConsumerState<FriendAllUI> {
  final ctrl = ScrollController();
  var sort = SortType.normal;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= ctrl.position.maxScrollExtent - MediaQuery.sizeOf(context).height / 2) {
        ref.read(friendControllerProvider.notifier).getAllFriends();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AFBAppBar(
          title: Text("Tất cả bạn bè", style: themeData.textTheme.titleMedium),
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: themeData.colorScheme.onInverseSurface, shape: BoxShape.circle),
                child: const Icon(Icons.search),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Consumer(
                  builder: (context, ref, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${ref.watch(friendControllerProvider).value?.totalAll ?? 0} Bạn bè",
                            style: themeData.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        child ?? Container()
                      ],
                    );
                  },
                  child: TextButton(
                      onPressed: () {
                        context.showAFBOptionModalBottomSheet(blocks: [
                          [
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    sort = SortType.normal;
                                  });
                                },
                                leading: Icons.filter_alt_off,
                                title: "Mặc định",
                                color:
                                    sort == SortType.normal ? themeData.colorScheme.primary : null),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    sort = SortType.ascending;
                                  });
                                },
                                leading: Icons.arrow_upward,
                                title: "Bạn bè lâu nhất trước tiên",
                                color: sort == SortType.ascending
                                    ? themeData.colorScheme.primary
                                    : null),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    sort = SortType.descending;
                                  });
                                },
                                leading: Icons.arrow_downward,
                                title: "Bạn bè mới nhất trước tiên",
                                color: sort == SortType.descending
                                    ? themeData.colorScheme.primary
                                    : null)
                          ]
                        ]);
                      },
                      child: const Text("Sắp xếp"))),
            ),
            Expanded(
              child: Builder(builder: (context) {
                var allFriends = ref
                    .watch(friendControllerProvider.select((value) => value.value?.allFriends))
                    ?.toList();
                if (sort != SortType.normal) {
                  allFriends?.sort(switch (sort) {
                    SortType.ascending => (a, b) => a.created.compareTo(b.created),
                    SortType.descending => (a, b) => b.created.compareTo(a.created),
                    _ => throw UnimplementedError(),
                  });
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.read(friendControllerProvider.notifier).refreshAllFriends();
                  },
                  child: (allFriends == null)
                      ? const Center(child: Text("Đang tải..."))
                      : ListView.custom(
                          controller: ctrl,
                          physics: const AlwaysScrollableScrollPhysics(),
                          childrenDelegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == allFriends.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: allFriends.length ==
                                                ref.read(friendControllerProvider).value?.totalAll
                                            ? const Text("Đã hết danh sách bạn bè.")
                                            : const CircularProgressIndicator()),
                                  );
                                }
                                return FriendAllItem(
                                    friend: allFriends[index],
                                    highlight: allFriends[index].id ==
                                        ModalRoute.of(context)?.settings.arguments);
                              },
                              childCount: allFriends.length + 1,
                              findChildIndexCallback: (key) {
                                var index = allFriends
                                    .indexWhere((e) => e.id == (key as ValueKey<int>).value);
                                if (index == -1) return null;
                                return index;
                              }),
                        ),
                );
              }),
            )
          ],
        ));
  }
}

class FriendAllItem extends ConsumerWidget {
  final Friend friend;
  final bool highlight;

  const FriendAllItem({super.key, required this.friend, this.highlight = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.sizeOf(context).width - 20,
      decoration: BoxDecoration(color: !highlight ? null : themeData.colorScheme.primaryContainer),
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
            ],
          )),
          IconButton(
              onPressed: () {
                context.showAFBOptionModalBottomSheet(
                    header: Row(
                      children: [
                        AFBCircleAvatar(imageUrl: friend.avatar, radius: 70),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(friend.username, style: themeData.textTheme.titleMedium),
                            Text(
                                "Là bạn bè từ tháng ${friend.created.month} năm ${friend.created.year}"),
                          ],
                        )),
                      ],
                    ),
                    blocks: [
                      [
                        AFBBottomSheetListTile(
                            onTap: () {
                              Fluttertoast.showToast(msg: "Tính năng đang phát triển.");
                            },
                            leading: Icons.chat_bubble,
                            title: "Nhắn tin cho ${friend.username}"),
                        AFBBottomSheetListTile(
                          onTap: () {
                            context.showAFBDialog(
                                title: Text("Chặn ${friend.username}?"),
                                actions: [
                                  GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text("THOÁT")),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(settingsControllerProvider.notifier)
                                          .setBlock(friend.id, friend.username, friend.avatar)
                                          .whenComplete(() => ref
                                              .read(friendControllerProvider.notifier)
                                              .removeFriendFromAll(friend.id));
                                    },
                                    child: Text("CHẶN",
                                        style: themeData.textTheme.bodyMedium
                                            ?.copyWith(color: themeData.colorScheme.primary)),
                                  ),
                                ],
                                content: Text(
                                    "Bạn có chắc muốn chặn ${friend.username}? ${friend.username} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Anti Fakebook."));
                          },
                          leading: Icons.block,
                          title: "Chặn ${friend.username}",
                          subtitle:
                              "${friend.username} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Anti Fakebook.",
                        ),
                        AFBBottomSheetListTile(
                          onTap: () {
                            context.showAFBDialog(
                                title: Text("Hủy kết bạn với ${friend.username}?"),
                                actions: [
                                  GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text("THOÁT")),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref
                                          .read(friendControllerProvider.notifier)
                                          .unfriend(friend.id);
                                    },
                                    child: Text("HỦY",
                                        style: themeData.textTheme.bodyMedium
                                            ?.copyWith(color: themeData.colorScheme.primary)),
                                  ),
                                ],
                                content: Text(
                                    "Bạn có chắc muốn hủy kết bạn với ${friend.username}? Nếu muốn kết bạn trở lại, bạn sẽ phải gửi lời mời kết bạn với họ."));
                          },
                          leading: Icons.group_remove,
                          title: "Hủy kết bạn với ${friend.username}",
                          subtitle: "Xóa ${friend.username} khỏi danh sách bạn bè.",
                          color: themeData.colorScheme.error,
                        ),
                      ]
                    ]);
              },
              icon: const Icon(Icons.more_horiz))
        ],
      ),
    );
  }
}
