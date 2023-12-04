import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/friend.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/settings.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/friend.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent) {
        ref.read(friendControllerProvider.notifier).getAllFriends();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AFBTransparentAppBar(
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
                        Text(
                            "${ref.watch(friendControllerProvider).value?.allFriends?.length ?? 0} Bạn bè",
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
                                color: sort == SortType.normal ? themeData.primaryColor : null),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    sort = SortType.ascending;
                                  });
                                },
                                leading: Icons.arrow_upward,
                                title: "Bạn bè lâu nhất trước tiên",
                                color: sort == SortType.ascending ? themeData.primaryColor : null),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    sort = SortType.descending;
                                  });
                                },
                                leading: Icons.arrow_downward,
                                title: "Bạn bè mới nhất trước tiên",
                                color: sort == SortType.descending ? themeData.primaryColor : null)
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
                return ListView.custom(
                  controller: ctrl,
                  physics: const AlwaysScrollableScrollPhysics(),
                  childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FriendAllItem(friend: allFriends![index]);
                      },
                      childCount: allFriends?.length ?? 0,
                      findChildIndexCallback: (key) {
                        var index =
                            allFriends?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
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

class FriendAllItem extends ConsumerWidget {
  final Friend friend;

  const FriendAllItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
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
                              onTap: () {},
                              leading: Icons.chat_bubble,
                              title: "Nhắn tin cho ${friend.username}"),
                          AFBBottomSheetListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ref
                                  .read(settingsControllerProvider.notifier)
                                  .setBlock(friend.id, friend.username, friend.avatar)
                                  .whenComplete(() => ref
                                      .read(friendControllerProvider.notifier)
                                      .removeFriendFromAll(friend.id));
                            },
                            leading: Icons.block,
                            title: "Chặn ${friend.username}",
                            subtitle:
                                "${friend.username} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Anti Fakebook.",
                          ),
                          AFBBottomSheetListTile(
                            onTap: () {},
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
      ),
    );
  }
}
