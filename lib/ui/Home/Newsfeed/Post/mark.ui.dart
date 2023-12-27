import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/helpers/emoji.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/helpers/text_formater.dart';
import 'package:Anti_Fakebook/models/mark.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkItem extends ConsumerStatefulWidget {
  final Mark mark;
  final int postId;
  final void Function(Mark) updateCallback;

  const MarkItem(
      {super.key, required this.mark, required this.postId, required this.updateCallback});

  @override
  ConsumerState<MarkItem> createState() => _MarkItemState();
}

class _MarkItemState extends ConsumerState<MarkItem> {
  bool isEditing = false;
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          AFBCircleAvatar(imageUrl: widget.mark.poster.avatar, radius: 40),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: widget.mark.typeOfMark == MarkType.trust
                    ? themeData.colorScheme.primaryContainer
                    : themeData.colorScheme.errorContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.mark.poster.name, style: themeData.textTheme.titleMedium),
                        Text(widget.mark.markContent)
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(formatPostCreatedTime(widget.mark.created)),
                    const SizedBox(width: 15),
                    TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        child: Text(isEditing ? "Hủy" : "Bình luận"))
                  ],
                ),
              ),
              if (isEditing)
                Builder(builder: (context) {
                  final themeData = Theme.of(context);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 4 * 3,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: AFBCircleAvatar(
                                imageUrl:
                                    ref.watch(profileControllerProvider).value?.profile?.avatar ??
                                        ""),
                          ),
                          Expanded(
                              child: TextField(
                            inputFormatters: const [EmojiInputFormatter()],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            autofocus: false,
                            controller: ctrl
                              ..addListener(() {
                                setState(() {});
                              }),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20), gapPadding: 0),
                                hintText: "<Comment>",
                                contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                                suffixIcon: IconButton(
                                  onPressed: ctrl.text == ""
                                      ? null
                                      : () {
                                          ref
                                              .read(newsfeedControllerProvider.notifier)
                                              .setMarkComment(widget.postId, ctrl.text,
                                                  markId: widget.mark.id)
                                              .then((value) {
                                            if (value.isEmpty) return;
                                            widget.updateCallback(value.first);
                                          });
                                          setState(() {
                                            ctrl.text = "";
                                            isEditing = false;
                                          });
                                        },
                                  icon: Icon(Icons.send,
                                      color:
                                          ctrl.text == "" ? null : themeData.colorScheme.primary),
                                )),
                          ))
                        ],
                      ),
                    ),
                  );
                }),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Column(
                  children: List.generate(
                      widget.mark.comments.length,
                      (index) => SizedBox(
                            width: MediaQuery.sizeOf(context).width / 4 * 3,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AFBCircleAvatar(
                                    imageUrl: widget.mark.comments[index].poster.avatar,
                                    radius: 40),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        elevation: 0,
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        color: themeData.colorScheme.tertiaryContainer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(widget.mark.comments[index].poster.name,
                                                    style: themeData.textTheme.titleMedium),
                                                AFBExpandableText(
                                                    text: widget.mark.comments[index].content)
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(formatPostCreatedTime(
                                            widget.mark.comments[index].created)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).reversed.toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MarkUI extends ConsumerStatefulWidget {
  final int postId;
  const MarkUI({super.key, required this.postId});

  @override
  ConsumerState<MarkUI> createState() => _MarkUIState();
}

class _MarkUIState extends ConsumerState<MarkUI> {
  List<Mark>? marks;

  @override
  void initState() {
    super.initState();
    ref
        .read(newsfeedControllerProvider.notifier)
        .getMarkComment(widget.postId, 0)
        .then((value) => setState(() {
              marks = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Mark", style: themeData.textTheme.titleMedium),
        ),
        const Divider(thickness: 5),
        Expanded(
          child: SingleChildScrollView(
            child: ((marks?.length ?? -1) != 0)
                ? Column(
                    children: List.generate(
                        marks?.length ?? 0,
                        (index) => MarkItem(
                            mark: marks![index],
                            postId: widget.postId,
                            updateCallback: (mark) {
                              setState(() {
                                marks = marks?.map((e) => e.id == mark.id ? mark : e).toList();
                              });
                            })).reversed.toList())
                : const Center(child: Text("Chưa có mark nào")),
          ),
        ),
      ],
    );
  }
}
