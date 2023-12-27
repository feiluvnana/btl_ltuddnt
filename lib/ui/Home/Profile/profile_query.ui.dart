import 'dart:math';

import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/models/friend.dart';
import 'package:Anti_Fakebook/models/profile.model.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:Anti_Fakebook/widgets/afb_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileQueryUI extends ConsumerStatefulWidget {
  final int userId;
  const ProfileQueryUI({super.key, required this.userId});

  @override
  ConsumerState<ProfileQueryUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends ConsumerState<ProfileQueryUI> {
  Profile? userinfo;
  Future<Profile?>? _future;
  List<Friend>? allFriends;

  @override
  void initState() {
    super.initState();
    _future = ref.read(profileControllerProvider.notifier).getUserInfo(widget.userId).then((value) {
      setState(() {
        userinfo = value;
      });
      return value;
    });
    ref.read(friendControllerProvider.notifier).getUserFriends(widget.userId).then((value) {
      setState(() {
        allFriends = value;
      });
      return value;
    });
  }

  void coverImageOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [
        AFBBottomSheetListTile(
            onTap: () {
              context.showImageView(url: userinfo?.coverImage ?? "");
            },
            leading: Icons.image,
            title: "Xem ảnh bìa"),
      ]
    ]);
  }

  void avatarOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [
        AFBBottomSheetListTile(
            onTap: () {
              context.showImageView(url: userinfo?.avatar ?? "");
            },
            leading: Icons.image,
            title: "Xem ảnh đại diện")
      ]
    ]);
  }

  void profileOptions() {
    context.showAFBOptionModalBottomSheet(
        header: Center(
            child: Text("Cài đặt trang cá nhân", style: Theme.of(context).textTheme.titleLarge)),
        blocks: [
          [
            AFBBottomSheetListTile(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: userinfo?.link ?? "Không có liên kết..."))
                      .whenComplete(() => Fluttertoast.showToast(msg: "Đã sao chép liên kết."));
                },
                leading: Icons.link,
                title: "Sao chép liên kết tới trang cá nhân",
                subtitle: userinfo?.link ?? "Không có liên kết...")
          ]
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final avatarDiameter = MediaQuery.orientationOf(context) == Orientation.portrait
        ? MediaQuery.sizeOf(context).width * 3 / 8
        : MediaQuery.sizeOf(context).width * 3 / 14;
    final imageSessionAspectRatio =
        MediaQuery.orientationOf(context) == Orientation.portrait ? 1.55 : 1.7;
    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(8),
                      clipBehavior: Clip.hardEdge,
                      decoration:
                          BoxDecoration(color: themeData.colorScheme.error, shape: BoxShape.circle),
                      child:
                          Icon(Icons.search_off, size: 50, color: themeData.colorScheme.surface)),
                  Text(
                    "Không thể lấy được thông tin người dùng.\nCó thể người dùng đã bị chặn, hoặc xóa tài khoản,...",
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ));
            }
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return AspectRatio(
                      aspectRatio: imageSessionAspectRatio,
                      child: Stack(children: [
                        Stack(
                          children: [
                            AspectRatio(
                                aspectRatio: 2,
                                child: AFBShimmer(
                                    enabled: userinfo == null,
                                    child: AFBNetworkImage(url: userinfo?.coverImage ?? ""))),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: coverImageOptions,
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: themeData.colorScheme.onInverseSurface),
                                      child: const Icon(Icons.camera_alt)),
                                )),
                          ],
                        ),
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Stack(
                              children: [
                                AFBShimmer(
                                  enabled: userinfo == null,
                                  child: Container(
                                    width: avatarDiameter,
                                    height: avatarDiameter,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: themeData.colorScheme.onPrimary, width: 2)),
                                    child: AFBCircleAvatar(imageUrl: userinfo?.avatar ?? ""),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: avatarOptions,
                                      child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: themeData.colorScheme.onInverseSurface),
                                          child: const Icon(Icons.camera_alt)),
                                    ))
                              ],
                            )),
                      ]),
                    );
                  }
                  if (index == 1) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AFBShimmer(
                        enabled: userinfo == null,
                        child: Text(userinfo?.username ?? "Username",
                            style: themeData.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800)),
                      ),
                    );
                  }
                  if (index == 2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: AFBShimmer(
                        enabled: userinfo == null,
                        child: Text(
                          userinfo?.description ?? "This is description.",
                        ),
                      ),
                    );
                  }
                  if (index == 3) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(children: [
                        Expanded(
                            child: userinfo?.isFriend == true
                                ? AFBDangerEButton(
                                    onPressed: () {
                                      ref
                                          .read(friendControllerProvider.notifier)
                                          .unfriend(userinfo!.id);
                                    },
                                    child: Text.rich(TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.group_remove,
                                              size: themeData.textTheme.bodyMedium?.fontSize),
                                          alignment: PlaceholderAlignment.middle),
                                      const TextSpan(text: " Hủy kết bạn")
                                    ])))
                                : AFBPrimaryEButton(
                                    onPressed: () {
                                      ref
                                          .read(friendControllerProvider.notifier)
                                          .setRequestFriend(userinfo!.id);
                                    },
                                    child: Text.rich(TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.group_add,
                                              size: themeData.textTheme.bodyMedium?.fontSize),
                                          alignment: PlaceholderAlignment.middle),
                                      const TextSpan(text: " Thêm bạn bè")
                                    ])))),
                        const SizedBox(width: 10),
                        AFBSecondaryEButton(
                            onPressed: profileOptions, child: const Icon(Icons.more_horiz))
                      ]),
                    );
                  }
                  if (index == 4 || index == 6 || index == 8) {
                    return const Divider(thickness: 5);
                  }
                  if (index == 5) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AFBShimmer(
                          enabled: userinfo == null,
                          child: AFBBottomSheetListTile(
                              onTap: null,
                              leading: Icons.home,
                              title: userinfo?.address ?? "Không có địa chỉ..."),
                        ),
                        AFBShimmer(
                          enabled: userinfo == null,
                          child: AFBBottomSheetListTile(
                              onTap: null,
                              leading: Icons.location_city,
                              title: userinfo?.city ?? "Không có thành phố..."),
                        ),
                        AFBShimmer(
                          enabled: userinfo == null,
                          child: AFBBottomSheetListTile(
                              onTap: null,
                              leading: Icons.location_on,
                              title: userinfo?.country ?? "Không có quốc gia..."),
                        ),
                        AFBShimmer(
                          enabled: userinfo == null,
                          child: AFBBottomSheetListTile(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg:
                                        "Hiện tại việc mua coins vẫn đang trong quá trình phát triển!");
                              },
                              leading: Icons.currency_bitcoin,
                              title: "${userinfo?.coins.toString()}"),
                        )
                      ],
                    );
                  }
                  if (index == 7) {
                    return Builder(builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bạn bè", style: themeData.textTheme.titleMedium),
                              AFBShimmer(
                                  enabled: userinfo == null,
                                  child: Text("${userinfo?.listing.toString() ?? "0"} bạn bè")),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                      min(allFriends?.length ?? 0, 6),
                                      (index) => Container(
                                            padding: const EdgeInsets.all(4),
                                            width: MediaQuery.sizeOf(context).width / 3.5,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AspectRatio(
                                                    aspectRatio: 1,
                                                    child: AFBNetworkImage(
                                                        url: allFriends![index].avatar)),
                                                Text(allFriends![index].username,
                                                    style: themeData.textTheme.titleSmall)
                                              ],
                                            ),
                                          )),
                                ),
                              ),
                              AFBSecondaryEButton(
                                  onPressed: () {},
                                  child: const Center(child: Text("Xem tất cả bạn bè")))
                            ]),
                      );
                    });
                  }
                  if (index == 9) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Bài viết", style: themeData.textTheme.titleMedium),
                    );
                  }
                  if (index == 10) {
                    return Container();
                  }
                  return Container();
                },
              ),
            );
          }),
    );
  }
}
