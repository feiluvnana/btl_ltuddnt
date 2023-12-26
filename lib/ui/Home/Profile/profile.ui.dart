import 'dart:io';
import 'dart:math';

import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/ui/Home/Friend/friend_all.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/newsfeed.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Profile/profile_change.ui.dart';
import 'package:Anti_Fakebook/ui/Home/home.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:Anti_Fakebook/widgets/afb_image_picker.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class ProfileUI extends ConsumerStatefulWidget {
  const ProfileUI({super.key});

  @override
  ConsumerState<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends ConsumerState<ProfileUI> {
  final ctrl = ScrollController();

  void coverImageOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [
        AFBBottomSheetListTile(
            onTap: () {
              var userinfo =
                  ref.watch(profileControllerProvider.select((value) => value.value?.profile));
              context.showImageView(url: userinfo?.coverImage ?? "");
            },
            leading: Icons.image,
            title: "Xem ảnh bìa"),
        AFBBottomSheetListTile(
            onTap: () {
              HLImagePickerAndroid()
                  .image(
                      pickerOptions:
                          const HLPickerOptions(minSelectedAssets: 1, maxSelectedAssets: 1))
                  .then((value) {
                if (value.isNotEmpty) {
                  ref
                      .read(profileControllerProvider.notifier)
                      .setUserInfo(coverImage: File(value[0].path));
                }
              });
            },
            leading: Icons.upload,
            title: "Tải ảnh lên"),
      ]
    ]);
  }

  void avatarOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [
        AFBBottomSheetListTile(
            onTap: () {
              var userinfo =
                  ref.watch(profileControllerProvider.select((value) => value.value?.profile));
              context.showImageView(url: userinfo?.avatar ?? "");
            },
            leading: Icons.image,
            title: "Xem ảnh đại diện"),
        AFBBottomSheetListTile(
            onTap: () {
              HLImagePickerAndroid()
                  .image(
                      pickerOptions:
                          const HLPickerOptions(minSelectedAssets: 1, maxSelectedAssets: 1))
                  .then((value) {
                if (value.isNotEmpty) {
                  ref
                      .read(profileControllerProvider.notifier)
                      .setUserInfo(avatar: File(value[0].path));
                }
              });
            },
            leading: Icons.upload,
            title: "Tải ảnh lên")
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const ProfileChangeUI()));
                },
                leading: Icons.edit,
                title: "Chỉnh sửa trang cá nhân")
          ],
          [
            AFBBottomSheetListTile(
                onTap: () {}, leading: Icons.search, title: "Tìm kiếm trên trang cá nhân")
          ],
          [
            AFBBottomSheetListTile(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                          text: ref
                                  .read(profileControllerProvider
                                      .select((value) => value.value?.profile))
                                  ?.link ??
                              "https://www.placeholder.com"))
                      .whenComplete(() => Fluttertoast.showToast(msg: "Đã sao chép liên kết."));
                },
                leading: Icons.link,
                title: "Sao chép liên kết tới trang cá nhân",
                subtitle: ref
                        .watch(profileControllerProvider.select((value) => value.value?.profile))
                        ?.link ??
                    "https://www.placeholder.com")
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
      body: Builder(builder: (context) {
        var userinfo = ref.watch(profileControllerProvider.select((value) => value.value?.profile));
        final posts = ref.watch(profileControllerProvider.select((value) => value.value?.posts));
        return RefreshIndicator(
          onRefresh: () async {
            ref.read(profileControllerProvider.notifier).refresh();
          },
          child: ListView.builder(
            controller: ctrl
              ..addListener(() {
                if (ctrl.offset >=
                    ctrl.position.maxScrollExtent - MediaQuery.sizeOf(context).height / 2) {
                  ref.read(profileControllerProvider.notifier).getPosts();
                }
              }),
            itemCount: 11 + (posts?.length ?? 0),
            itemBuilder: (context, index) {
              if (index == 0) {
                return AspectRatio(
                  aspectRatio: imageSessionAspectRatio,
                  child: Stack(children: [
                    Stack(
                      children: [
                        AspectRatio(
                            aspectRatio: 2,
                            child: AFBNetworkImage(url: userinfo?.coverImage ?? "")),
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
                            Container(
                              width: avatarDiameter,
                              height: avatarDiameter,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: themeData.colorScheme.onPrimary, width: 2)),
                              child: AFBCircleAvatar(imageUrl: userinfo?.avatar ?? ""),
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
                  child: Text(userinfo?.username ?? "",
                      style: themeData.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                );
              }
              if (index == 2) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    userinfo?.description ?? "",
                  ),
                );
              }
              if (index == 3) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(children: [
                    Expanded(
                        child: AFBSecondaryEButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const ProfileChangeUI()));
                            },
                            child: Text.rich(TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(Icons.edit,
                                      size: themeData.textTheme.bodyMedium?.fontSize),
                                  alignment: PlaceholderAlignment.middle),
                              const TextSpan(text: " Chỉnh sửa trang cá nhân")
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
                    AFBBottomSheetListTile(
                        onTap: null,
                        leading: Icons.home,
                        title: userinfo?.address ?? "Không có địa chỉ..."),
                    AFBBottomSheetListTile(
                        onTap: null,
                        leading: Icons.location_city,
                        title: userinfo?.city ?? "Không có thành phố..."),
                    AFBBottomSheetListTile(
                        onTap: null,
                        leading: Icons.location_on,
                        title: userinfo?.country ?? "Không có quốc gia..."),
                    AFBBottomSheetListTile(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Hiện tại việc mua coins vẫn đang trong quá trình phát triển!");
                        },
                        leading: Icons.currency_bitcoin,
                        title: "${userinfo?.coins.toString()}")
                  ],
                );
              }
              if (index == 7) {
                return Builder(builder: (context) {
                  var profile =
                      ref.watch(profileControllerProvider.select((value) => value.value?.profile));
                  var requestedFriends = ref.watch(
                      friendControllerProvider.select((value) => value.value?.requestedFriends));
                  var allFriends = ref
                      .watch(friendControllerProvider.select((value) => value.value?.allFriends));
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bạn bè", style: themeData.textTheme.titleMedium),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    HomeUIState.tabController.index = 1;
                                  },
                                  child: Text.rich(TextSpan(children: [
                                    const TextSpan(text: "Lời mời kết bạn "),
                                    TextSpan(
                                        text: requestedFriends?.length.toString() ?? "",
                                        style: themeData.textTheme.bodyMedium?.copyWith(
                                            color: themeData.colorScheme.error,
                                            fontWeight: FontWeight.bold))
                                  ])))
                            ],
                          ),
                          Text("${profile?.listing.toString() ?? "0"} bạn bè"),
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
                                            Text(allFriends[index].username,
                                                style: themeData.textTheme.titleSmall)
                                          ],
                                        ),
                                      )),
                            ),
                          ),
                          AFBSecondaryEButton(
                              onPressed: () {
                                Navigator.pop(context);
                                HomeUIState.tabController.index = 1;
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const FriendAllUI()));
                              },
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
                return const CreatePostBar();
              }
              return switch (posts?.isEmpty) {
                null => const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                false =>
                  PostItem(key: ValueKey<int>(posts![index - 11].id), post: posts[index - 11]),
                true => const Center(child: Text("Không có bài viết..."))
              };
            },
            findChildIndexCallback: (key) {
              var index =
                  posts?.indexWhere((element) => element.id == (key as ValueKey<int>?)?.value);
              if (index == -1 || index == null) return null;
              return index + 11;
            },
          ),
        );
      }),
    );
  }
}
