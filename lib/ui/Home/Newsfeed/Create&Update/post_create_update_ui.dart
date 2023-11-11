import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/media_view.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class PostCreateUpdateUI extends StatefulWidget {
  final Post? post;

  const PostCreateUpdateUI({super.key, this.post});

  @override
  State<PostCreateUpdateUI> createState() => _PostCreateUpdateUIState();
}

class _PostCreateUpdateUIState extends State<PostCreateUpdateUI> {
  final ctrl = TextEditingController();
  final List<dynamic> options = [
    {"label": "\u{1f5bc} Ảnh/Video", "action": () {}},
    {"label": "\u{1f600} Cảm xúc/Hoạt động", "action": () {}},
    {"label": "\u{1f4f7} Camera", "action": () {}}
  ];
  final focusNode = FocusNode();
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
            ? (await showModalBottomSheet<bool>(
                    shape: const RoundedRectangleBorder(),
                    context: context,
                    builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                "Bạn muốn hoàn thành bài viết của mình sau?",
                                style: themeData.textTheme.bodyLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                              child: Text(
                                "Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa",
                                style: themeData.textTheme.bodySmall,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  //save draft
                                  Navigator.maybePop(context, true);
                                },
                                child: const Row(
                                    children: [Icon(Icons.save), Text(" Lưu làm bản nháp")]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.maybePop(context, true);
                                },
                                child:
                                    const Row(children: [Icon(Icons.delete), Text(" Bỏ bài viết")]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.maybePop(context, false);
                                },
                                child: Row(children: [
                                  Icon(
                                    Icons.check,
                                    color: themeData.primaryColor,
                                  ),
                                  Text(" Tiếp tục chỉnh sửa",
                                      style: themeData.textTheme.bodyMedium
                                          ?.copyWith(color: themeData.primaryColor))
                                ]),
                              ),
                            ),
                          ],
                        )) ??
                false)
            : (await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            "Bỏ thay đổi?",
                            style: themeData.textTheme.bodyLarge,
                          ),
                          content: const Text(
                              "Nếu bỏ bây giờ thì bạn sẽ mất mọi thay đổi trên bài viết này."),
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
                        )) ??
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
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
          actions: [TextButton(onPressed: () {}, child: const Text("ĐĂNG"))],
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleUserAvatar(),
                  const SizedBox(width: 10),
                  Text(
                    "Author Placeholder",
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
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
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        child: Text(label));
  }
}
