import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/profile.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image_picker.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

class ProfileChangeUI extends ConsumerStatefulWidget {
  const ProfileChangeUI({super.key});

  @override
  ConsumerState<ProfileChangeUI> createState() => _ProfileChangeUIState();
}

class _ProfileChangeUIState extends ConsumerState<ProfileChangeUI> {
  HLPickerItem? avatar;
  HLPickerItem? coverImage;
  final bio = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        title: Text("Chỉnh sửa trang cá nhân", style: themeData.textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.sizeOf(context).height / 3,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ảnh đại diện", style: themeData.textTheme.titleMedium),
                        TextButton(
                            onPressed: () {
                              HLImagePickerAndroid()
                                  .image(
                                      selectedIds: (avatar != null) ? [avatar!.id] : null,
                                      pickerOptions: const HLPickerOptions(
                                          minSelectedAssets: 1, maxSelectedAssets: 1))
                                  .then((value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    avatar = value[0];
                                  });
                                }
                              });
                            },
                            child: const Text("Chỉnh sửa"))
                      ],
                    ),
                    Expanded(
                        child: Center(
                            child: avatar != null
                                ? Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black12)),
                                    child: Image.file(
                                      File(avatar!.path),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.sizeOf(context).height / 6,
                                      height: MediaQuery.sizeOf(context).height / 6,
                                    ),
                                  )
                                : AFBCircleAvatar(
                                    radius: MediaQuery.sizeOf(context).height / 6,
                                    imageUrl: ref.watch(profileControllerProvider
                                        .select((value) => value.value!.profile!.avatar)))))
                  ]),
            ),
            const Divider(thickness: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.sizeOf(context).height / 3,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ảnh bìa", style: themeData.textTheme.titleMedium),
                        TextButton(
                            onPressed: () {
                              HLImagePickerAndroid()
                                  .image(
                                      selectedIds: (coverImage != null) ? [coverImage!.id] : null,
                                      pickerOptions: const HLPickerOptions(
                                          minSelectedAssets: 1, maxSelectedAssets: 1))
                                  .then((value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    coverImage = value[0];
                                  });
                                }
                              });
                            },
                            child: const Text("Chỉnh sửa"))
                      ],
                    ),
                    Expanded(
                        child: Center(
                            child: coverImage != null
                                ? Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: Image.file(File(coverImage!.path), fit: BoxFit.cover),
                                  )
                                : AFBNetworkImage(
                                    url: ref.watch(profileControllerProvider
                                        .select((value) => value.value!.profile!.coverImage)))))
                  ]),
            ),
            const Divider(thickness: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tiểu sử", style: themeData.textTheme.titleMedium),
                        TextButton(onPressed: () {}, child: const Text("Chỉnh sửa"))
                      ],
                    ),
                    Builder(builder: (context) {
                      var bioText = ref.watch(profileControllerProvider
                          .select((value) => value.value!.profile!.description));
                      return Center(
                          child: bio.text.isNotEmpty
                              ? Text(bio.text)
                              : bioText.isNotEmpty
                                  ? Text(bioText)
                                  : Text("Mô tả bản thân...",
                                      style: themeData.textTheme.bodyMedium
                                          ?.copyWith(color: themeData.colorScheme.secondary)));
                    })
                  ]),
            ),
            const Divider(thickness: 5),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chi tiết", style: themeData.textTheme.titleMedium),
                        TextButton(onPressed: () {}, child: const Text("Chỉnh sửa"))
                      ],
                    ),
                    AFBBottomSheetListTile(
                        onTap: null,
                        leading: Icons.home,
                        title: address.text.isNotEmpty
                            ? address.text
                            : ref.watch(profileControllerProvider
                                .select((value) => value.value!.profile!.address)))
                  ],
                )),
            const Divider(thickness: 5),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Liên kết", style: themeData.textTheme.titleMedium),
                        TextButton(onPressed: () {}, child: const Text("Chỉnh sửa"))
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
