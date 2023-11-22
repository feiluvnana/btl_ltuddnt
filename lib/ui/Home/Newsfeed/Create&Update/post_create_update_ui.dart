import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/media_view.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PostCreateUpdateUI extends StatefulWidget {
  final Post? post;

  const PostCreateUpdateUI({super.key, this.post});

  @override
  State<PostCreateUpdateUI> createState() => _PostCreateUpdateUIState();
}

class _PostCreateUpdateUIState extends State<PostCreateUpdateUI> {
  final ctrl = TextEditingController();
  late final List<dynamic> options = [
    {
      "label": "\u{1f5bc} Ảnh/Video",
      "action": () {
        ImagePicker().pickMultiImage().then((value) {
          setState(() {
            images = value.map((e) => File(e.path)).toList();
            medias = value.map((e) => Image.file(File(e.path), fit: BoxFit.cover)).toList();
          });
        });
      }
    },
    {"label": "\u{1f600} Cảm xúc/Hoạt động", "action": () {}},
    {"label": "\u{1f4f7} Camera", "action": () {}}
  ];
  final focusNode = FocusNode();

  List<File>? images;
  File? video;

  List<Widget> medias = [];
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    medias = widget.post?.image?.map((e) => Image.network(e.url)).toList() ?? [];
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

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        bool isPop = false;
        isPop = (widget.post == null)
            ? (await showAFBModalBottomSheet<bool>(
                    context: context,
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
                              //TODO: Save draft
                              Navigator.maybePop(context, true);
                            },
                            leading: Icons.save,
                            title: "Lưu làm bản nháp"),
                        AFBBottomSheetListTile(
                            onTap: () {
                              Navigator.maybePop(context, true);
                            },
                            leading: Icons.delete,
                            title: "Bỏ bài viết"),
                        AFBBottomSheetListTile(
                            onTap: () {
                              Navigator.maybePop(context, false);
                            },
                            color: themeData.primaryColor,
                            leading: Icons.check,
                            title: "Tiếp tục chỉnh sửa")
                      ]
                    ]) ??
                false)
            : (await showAFBDialog<bool>(
                  context: context,
                  title: Text("Bỏ thay đổi?", style: themeData.textTheme.bodyLarge),
                  content:
                      const Text("Nếu bỏ bây giờ thì bạn sẽ mất mọi thay đổi trên bài viết này."),
                  actions: [
                    GestureDetector(
                        onTap: () {
                          Navigator.maybePop(context, false);
                        },
                        child: const Text("TIẾP TỤC CHỈNH SỬA")),
                    GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context, true);
                      },
                      child: Text("BỎ",
                          style: themeData.textTheme.bodyMedium
                              ?.copyWith(color: themeData.primaryColor)),
                    )
                  ],
                ) ??
                false);
        return isPop;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: TransparentAppBar(
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
                  context.read<NewsfeedBloc>().add(NewsfeedAddPost(
                      described: ctrl.text, status: "Not Hyped", image: images, video: video));
                  Navigator.pop(context);
                },
                child: const Text("ĐĂNG"))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocBuilder<AuthenBloc, AuthenState>(
                buildWhen: (previous, current) => previous.user != current.user,
                builder: (context, state) {
                  return Row(
                    children: [
                      CircularUserAvatar(imageUrl: state.user?.avatar ?? ""),
                      const SizedBox(width: 10),
                      Text(
                        state.user?.username ?? "",
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
                    border: InputBorder.none,
                    hintText: "Bạn đang nghĩ gì?",
                  ),
                )),
            AspectRatio(
                aspectRatio: 1,
                child: GridMediaView(
                  medias: medias,
                  onClickMedia: (index) {},
                )),
            SizedBox(height: !isExpanded ? 50 : 150)
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
                            3,
                            (index) => _CreatePostOption(
                                action: options[index]["action"], label: options[index]["label"])))
                    : Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey))),
                        child: Row(
                          children: [
                            ...List.generate(
                                3,
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
      )),
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
