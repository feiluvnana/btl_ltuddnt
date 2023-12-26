import 'dart:io';

import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:Anti_Fakebook/widgets/afb_image_picker.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
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
  final description = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController();
  final link = TextEditingController();

  bool editDescription = false;
  bool editLocation = false;
  bool editLink = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        title: Text("Chỉnh sửa trang cá nhân", style: themeData.textTheme.titleMedium),
        actions: [
          TextButton(
              onPressed: () {
                ref.read(profileControllerProvider.notifier).setUserInfo(
                    avatar: avatar != null ? File(avatar!.path) : null,
                    coverImage: coverImage != null ? File(coverImage!.path) : null,
                    description: description.text != "" ? description.text : null,
                    address: address.text != "" ? address.text : null,
                    city: city.text != "" ? city.text : null,
                    country: country.text != "" ? country.text : null,
                    link: link.text != "" ? link.text : null);
                Navigator.pop(context);
              },
              child: const Text("Lưu"))
        ],
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
                                    width: MediaQuery.sizeOf(context).width,
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
                        TextButton(
                            onPressed: () {
                              if (editDescription) description.text = "";
                              setState(() {
                                editDescription = !editDescription;
                              });
                            },
                            child: Text(editDescription ? "Hủy bỏ" : "Chỉnh sửa"))
                      ],
                    ),
                    (editDescription)
                        ? TextField(
                            controller: description,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: "Tiểu sử"))
                        : Builder(builder: (context) {
                            var descriptionText = ref.watch(profileControllerProvider
                                .select((value) => value.value!.profile!.description));
                            return Center(
                                child: descriptionText.isNotEmpty
                                    ? Text(descriptionText)
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
                        TextButton(
                            onPressed: () {
                              if (editLocation) {
                                city.text = "";
                                country.text = "";
                                address.text = "";
                              }
                              setState(() {
                                editLocation = !editLocation;
                              });
                            },
                            child: Text(editLocation ? "Hủy bỏ" : "Chỉnh sửa"))
                      ],
                    ),
                    if (!editLocation) ...[
                      Builder(builder: (context) {
                        var addressText = ref.watch(profileControllerProvider
                            .select((value) => value.value!.profile!.address));
                        return AFBBottomSheetListTile(
                            onTap: null,
                            leading: Icons.home,
                            title: addressText.isNotEmpty ? addressText : "Không có địa chỉ...");
                      }),
                      Builder(builder: (context) {
                        var cityText = ref.watch(profileControllerProvider
                            .select((value) => value.value!.profile!.city));
                        return AFBBottomSheetListTile(
                            onTap: null,
                            leading: Icons.location_city,
                            title: cityText.isNotEmpty ? cityText : "Không có thành phố...");
                      }),
                      Builder(builder: (context) {
                        var countryText = ref.watch(profileControllerProvider
                            .select((value) => value.value!.profile!.country));
                        return AFBBottomSheetListTile(
                            onTap: null,
                            leading: Icons.location_city,
                            title: countryText.isNotEmpty ? countryText : "Không có quốc gia...");
                      }),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: address,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: "Địa chỉ")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: city,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: "Thành phố")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: country,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: "Quốc gia")),
                      )
                    ]
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
                        TextButton(
                            onPressed: () {
                              if (editLink) link.text = "";
                              setState(() {
                                editLink = !editLink;
                              });
                            },
                            child: Text(editLink ? "Hủy bỏ" : "Chỉnh sửa"))
                      ],
                    ),
                    (editLink)
                        ? TextField(
                            controller: link,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: "Liên kết"))
                        : Builder(builder: (context) {
                            var linkText = ref.watch(profileControllerProvider
                                .select((value) => value.value!.profile!.link));
                            return Center(
                                child: linkText.isNotEmpty
                                    ? Text(linkText)
                                    : Text("Không có liên kết...",
                                        style: themeData.textTheme.bodyMedium
                                            ?.copyWith(color: themeData.colorScheme.secondary)));
                          })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
