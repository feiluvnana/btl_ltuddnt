import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/video.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_grid_image_view.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image_picker.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PostCreateModifyUI extends ConsumerStatefulWidget {
  final Post? post;

  const PostCreateModifyUI({super.key, this.post});

  @override
  ConsumerState<PostCreateModifyUI> createState() => _PostCreateUpdateUIState();
}

class _PostCreateUpdateUIState extends ConsumerState<PostCreateModifyUI> {
  late final List<dynamic> options = [
    {
      "label": "\u{1f5bc} Ảnh",
      "action": () async {
        await HLImagePickerAndroid()
            .image(
                cropping: false,
                selectedIds: image?.whereType<HLPickerItem>().map((e) => e.id).toList(),
                pickerOptions: const HLPickerOptions(maxSelectedAssets: 4))
            .then((value) {
          setState(() {
            video = null;
            image = [...image?.whereType<Widget>().toList() ?? [], ...value];
          });
        });
      }
    },
    {
      "label": "\u{1f4f9} Video",
      "action": () async {
        await HLImagePickerAndroid()
            .video(
                cropping: false,
                selectedIds: video is HLPickerItem ? [(video as HLPickerItem).id] : null,
                pickerOptions: const HLPickerOptions(maxSelectedAssets: 1))
            .then((value) {
          setState(() {
            video = value.first;
            image = null;
          });
        });
      }
    },
    {"label": "\u{1f600} Cảm xúc/Hoạt động", "action": () {}},
    {"label": "\u{1f4f7} Camera", "action": () {}}
  ];
  final ctrl = TextEditingController();
  final focusNode = FocusNode();
  var isExpanded = true;
  var canPop = false;

  List<dynamic>? image;
  dynamic video;

  //For edit image
  List<AFBNetworkImage>? initialImage;

  bool equals(dynamic image1, dynamic image2) {
    if (image1 is AFBNetworkImage && image2 is AFBNetworkImage) {
      if (image1.url == image2.url) return true;
    }
    if (image1 is HLPickerItem && image2 is HLPickerItem) {
      if (image1.id == image2.id) return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    image =
        widget.post?.image?.map((e) => AFBNetworkImage(url: e.url, fit: BoxFit.cover)).toList() ??
            [];
    initialImage =
        widget.post?.image?.map((e) => AFBNetworkImage(url: e.url, fit: BoxFit.cover)).toList() ??
            [];
    video = widget.post?.video;
    ctrl.text = Emoji.revert(widget.post?.described ?? "");
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isExpanded = false;
        });
      } else {
        setState(() {
          isExpanded = true;
        });
      }
    });
  }

  Future<bool> decideCanPop() async {
    if (canPop) return true;
    final themeData = Theme.of(context);
    return (widget.post == null)
        ? (await context.showAFBOptionModalBottomSheet<bool>(
                header: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bạn muốn hoàn thành bài viết của mình sau?",
                        style: themeData.textTheme.bodyLarge),
                    Text("Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa",
                        style: themeData.textTheme.bodySmall),
                  ],
                ),
                blocks: [
                  [
                    AFBBottomSheetListTile(
                        onTap: () {
                          setState(() {
                            canPop = true;
                          });
                          Navigator.maybePop(context, true);
                        },
                        leading: Icons.delete,
                        title: "Bỏ bài viết"),
                    AFBBottomSheetListTile(
                        onTap: () {
                          Navigator.maybePop(context, false);
                        },
                        color: themeData.colorScheme.primary,
                        leading: Icons.check,
                        title: "Tiếp tục chỉnh sửa")
                  ]
                ]) ??
            false)
        : (await context.showAFBDialog<bool>(
              title: Text("Bỏ thay đổi?", style: themeData.textTheme.bodyLarge),
              content: const Text("Nếu bỏ bây giờ thì bạn sẽ mất mọi thay đổi trên bài viết này."),
              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.maybePop(context, false);
                    },
                    child: const Text("TIẾP TỤC CHỈNH SỬA")),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      canPop = true;
                    });
                    Navigator.maybePop(context, true);
                  },
                  child: Text("BỎ",
                      style: themeData.textTheme.bodyMedium
                          ?.copyWith(color: themeData.colorScheme.primary)),
                )
              ],
            ) ??
            false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) => decideCanPop().then((value) {
        if (value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.maybePop(context);
          });
        }
      }),
      child: Scaffold(
        appBar: AFBAppBar(
          title: Text(
            widget.post == null ? "Tạo bài viết" : "Chỉnh sửa bài viết",
            style: themeData.textTheme.titleMedium,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            TextButton(
                onPressed: () {
                  if (widget.post == null) {
                    ref.read(newsfeedControllerProvider.notifier).addPost(
                        described: ctrl.text,
                        status: "Not Hyped",
                        image: image?.map((e) => File(e.path)).toList(),
                        video:
                            video is HLPickerItem ? File((video as HLPickerItem).path) : File(""));
                  } else {
                    List<HLPickerItem>? newImage = image?.whereType<HLPickerItem>().toList();
                    List<int>? newIndexOfInitialImage = initialImage
                        ?.map<int>((e1) => image!.indexWhere((e2) => equals(e1, e2)))
                        .toList();
                    List<int>? imageDel;
                    List<int>? imageSort;
                    for (var i = 0; i < (newIndexOfInitialImage?.length ?? 0); i++) {
                      if (newIndexOfInitialImage?[i] == -1) {
                        imageDel = [...imageDel ?? [], i + 1];
                      }
                    }
                    imageSort = newImage?.isNotEmpty == true
                        ? null
                        : newIndexOfInitialImage?.map((e) => e + 1).toList();
                    ref.read(newsfeedControllerProvider.notifier).editPost(
                        id: widget.post!.id,
                        described: ctrl.text,
                        video: video,
                        image: newImage?.map<File>((e) => File(e.path)).toList(),
                        imageDel: imageDel,
                        imageSort: imageSort,
                        status: "Not Hyped");
                  }

                  Navigator.maybePop(context);
                },
                child: Text(widget.post != null ? "CHỈNH SỬA" : "ĐĂNG"))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Builder(
                builder: (context) {
                  final user =
                      ref.watch(authenControllerProvider.select((value) => value.value?.user));
                  return Row(
                    children: [
                      AFBCircleAvatar(imageUrl: user?.avatar ?? ""),
                      const SizedBox(width: 10),
                      Text(
                        user?.username ?? "",
                        style:
                            themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: ctrl,
                  inputFormatters: const [EmojiInputFormatter()],
                  keyboardType: TextInputType.multiline,
                  focusNode: focusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Bạn đang nghĩ gì?"),
                )),
            if (image?.isNotEmpty == true)
              AspectRatio(
                  aspectRatio: 1,
                  child: AFBGridImageEdit(
                    image: image!,
                    onUpdated: (image, {begin, end, deleted}) {
                      setState(() {
                        this.image = image;
                      });
                      print("---\n$image\n$begin\n$end\n$deleted");
                    },
                  )),
            if (video != null)
              Stack(
                children: [
                  FutureBuilder(
                    future: VideoThumbnail.thumbnailFile(
                        video: video is HLPickerItem
                            ? (video as HLPickerItem).path
                            : (video as Video).url ?? ""),
                    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Image.file(File(snapshot.data ?? ""),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Container()),
                      );
                    },
                  ),
                  Positioned.fill(
                      child: Center(
                    child: Icon(Icons.play_arrow, color: themeData.colorScheme.onPrimary, size: 50),
                  ))
                ],
              ),
            SizedBox(height: !isExpanded ? 50 : 200)
          ]),
        ),
        bottomSheet: Theme(
          data: ThemeData(
              bottomSheetTheme: const BottomSheetThemeData(shape: RoundedRectangleBorder())),
          child: BottomSheet(
              onClosing: () {},
              builder: (context) {
                return (isExpanded)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            4,
                            (index) => _CreatePostOption(
                                action: options[index]["action"], label: options[index]["label"])))
                    : Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(border: Border(top: BorderSide())),
                        child: Row(
                          children: [
                            ...List.generate(
                                4,
                                (index) => Expanded(
                                    child: Center(
                                        child: Text(options[index]["label"]
                                            .substring(0, options[index]["label"].indexOf(" ")))))),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    focusNode.unfocus();
                                  },
                                  child: const Center(child: Icon(Icons.more_horiz))),
                            )
                          ],
                        ));
              }),
        ),
      ),
    );
  }
}

class _CreatePostOption extends StatelessWidget {
  final void Function() action;
  final String label;

  const _CreatePostOption({required this.action, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
          child: Text(label)),
    );
  }
}
