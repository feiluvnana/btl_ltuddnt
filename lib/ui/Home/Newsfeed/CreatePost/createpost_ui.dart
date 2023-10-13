import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePostUI extends StatefulWidget {
  const CreatePostUI({super.key});

  @override
  State<CreatePostUI> createState() => _CreatePostUIState();
}

class _CreatePostUIState extends State<CreatePostUI> {
  final ctrl = TextEditingController();
  final List<dynamic> options = [
    {"label": "\u{1f5bc} Ảnh/Video", "action": () {}},
    {"label": "\u{1f600} Cảm xúc/Hoạt động", "action": () {}},
    {"label": "\u{1f4f7} Camera", "action": () {}}
  ];
  final focusNode = FocusNode();
  List<Widget> medias = [
    Container(
        decoration: BoxDecoration(border: Border.all()),
        child: const FlutterLogo()),
    Container(
        decoration: BoxDecoration(border: Border.all()),
        child: const FlutterLogo()),
    Container(
        decoration: BoxDecoration(border: Border.all()),
        child: const FlutterLogo()),
  ];
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
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
        isPop = await showModalBottomSheet<bool>(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
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
                            child: const Row(children: [
                              Icon(Icons.save),
                              Text(" Lưu làm bản nháp")
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.maybePop(context, true);
                            },
                            child: const Row(children: [
                              Icon(Icons.delete),
                              Text(" Bỏ bài viết")
                            ]),
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
            false;
        return isPop;
      },
      child: SafeArea(
          child: Scaffold(
        appBar: TransparentAppBar(
          title: Text(
            "Tạo bài viết",
            style: themeData.textTheme.titleMedium,
          ),
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back)),
          actions: [TextButton(onPressed: () {}, child: const Text("ĐĂNG"))],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleUserAvatar(),
                  SizedBox(width: 10),
                  _CreatePostAuthor(),
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
            AspectRatio(aspectRatio: 1, child: MediaView(medias: medias)),
            SizedBox(height: !isExpanded ? 50 : 150)
          ]),
        ),
        bottomSheet: Theme(
          data: ThemeData(
              bottomSheetTheme:
                  const BottomSheetThemeData(shape: RoundedRectangleBorder())),
          child: BottomSheet(
              onClosing: () {},
              builder: (context) {
                return (isExpanded)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            3,
                            (index) => _CreatePostOption(
                                action: options[index]["action"],
                                label: options[index]["label"])))
                    : Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(
                            border:
                                Border(top: BorderSide(color: Colors.grey))),
                        child: Row(
                          children: [
                            ...List.generate(
                                3,
                                (index) => Expanded(
                                    child: Center(
                                        child: Text(options[index]["label"]
                                            .substring(
                                                0,
                                                options[index]["label"]
                                                    .indexOf(" ")))))),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    focusNode.unfocus();
                                  },
                                  child: const Center(
                                      child: Icon(Icons.more_horiz))),
                            )
                          ],
                        ));
              }),
        ),
      )),
    );
  }
}

class _CreatePostAuthor extends StatelessWidget {
  final String? author;

  const _CreatePostAuthor({this.author});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Text(
        author ?? "Author Placeholder",
        style: themeData.textTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MediaView extends StatelessWidget {
  final List<Widget> medias;

  const MediaView({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return switch (medias.length) {
      1 => medias.first,
      2 => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1 / 2,
          children: medias),
      3 => Row(children: [
          Expanded(
              child: Column(
            children: medias
                .sublist(0, 2)
                .map((e) => AspectRatio(
                      aspectRatio: 1,
                      child: e,
                    ))
                .toList(),
          )),
          Expanded(child: AspectRatio(aspectRatio: 1 / 2, child: medias[2]))
        ]),
      _ => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: medias)
    };
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
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey))),
        child: Text(label));
  }
}
