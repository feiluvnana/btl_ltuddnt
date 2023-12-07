import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/profile.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/profile.model.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Profile/profile_change.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileOtherUI extends ConsumerStatefulWidget {
  final int userId;
  const ProfileOtherUI({super.key, required this.userId});

  @override
  ConsumerState<ProfileOtherUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends ConsumerState<ProfileOtherUI> {
  late Future<Profile?> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(profileControllerProvider.notifier).getUserInfo(widget.userId);
  }

  void coverImageOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [
        AFBBottomSheetListTile(onTap: () {}, leading: Icons.image, title: "Xem ảnh bìa"),
        AFBBottomSheetListTile(onTap: () {}, leading: Icons.upload, title: "Tải ảnh lên"),
      ]
    ]);
  }

  void avatarOptions() {
    context.showAFBOptionModalBottomSheet(blocks: [
      [AFBBottomSheetListTile(onTap: () {}, leading: Icons.image, title: "Chọn ảnh đại diện")]
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
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return AspectRatio(
                      aspectRatio: imageSessionAspectRatio,
                      child: Stack(children: [
                        Stack(
                          children: [
                            const AspectRatio(
                              aspectRatio: 2,
                              child: Placeholder(),
                            ),
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
                                      border: Border.all(
                                          color: themeData.colorScheme.onPrimary, width: 2)),
                                  child: AFBCircleAvatar(
                                    imageUrl: snapshot.data?.avatar ?? "image/default",
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
                    return AFBShimmer(
                      enabled: snapshot.data == null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(snapshot.data?.username ?? "Username",
                            style: themeData.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800)),
                      ),
                    );
                  }
                  if (index == 2) {
                    return AFBShimmer(
                      enabled: snapshot.data == null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          snapshot.data?.description ?? "This is bio",
                        ),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProfileChangeUI()));
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
                    return AFBShimmer(
                      enabled: snapshot.data == null,
                      child: AFBBottomSheetListTile(
                          onTap: null,
                          leading: Icons.home,
                          title: snapshot.data?.city ?? "This is the city."),
                    );
                  }
                  if (index == 7) {
                    return Container();
                    // return Builder(builder: (context) {
                    //   return Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10),
                    //     child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Bạn bè", style: themeData.textTheme.titleMedium),
                    //           Text("${snapshot.data?.listing.toString() ?? "0"} bạn bè"),
                    //           Center(
                    //             child: Wrap(
                    //               alignment: WrapAlignment.center,
                    //               children: List.generate(
                    //                   min(allFriends?.length ?? 0, 6),
                    //                   (index) => SizedBox(
                    //                         width: MediaQuery.sizeOf(context).width / 3.5,
                    //                         height: MediaQuery.sizeOf(context).width / 3.5,
                    //                         child: Column(
                    //                           children: [
                    //                             Expanded(
                    //                                 child: AFBNetworkImage(
                    //                                     url: allFriends![index].avatar)),
                    //                             Text(allFriends[index].username,
                    //                                 style: themeData.textTheme.titleMedium)
                    //                           ],
                    //                         ),
                    //                       )),
                    //             ),
                    //           ),
                    //           AFBSecondaryEButton(
                    //               onPressed: () {},
                    //               child: const Center(child: Text("Xem tất cả bạn bè")))
                    //         ]),
                    //   );
                    // });
                  }
                  if (index == 8) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Bài viết", style: themeData.textTheme.titleMedium),
                    );
                  }
                  // if (index == 9) {
                  //   return const CreatePostBar();
                  // }
                  return null;
                  // return switch (posts?.isEmpty) {
                  //   null => const Center(
                  //         child: Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: CircularProgressIndicator(),
                  //     )),
                  //   false =>
                  //     PostItem(key: ValueKey<int>(posts![index - 10].id), post: posts[index - 10]),
                  //   true => const Center(child: Text("Không có bài viết..."))
                  // };
                },
                findChildIndexCallback: (key) {
                  return null;
                  // var index =
                  //     posts?.indexWhere((element) => element.id == (key as ValueKey<int>?)?.value);
                  // if (index == -1 || index == null) return null;
                  // return index + 10;
                },
              ),
            );
          }),
    );
  }
}
