// ignore_for_file: unused_element

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/post_media_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/media_view.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/reaction_display.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/skeleton_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostUI extends StatefulWidget {
  final Post post;

  const PostUI({super.key, required this.post});

  @override
  State<PostUI> createState() => _PostUIState();
}

class _PostUIState extends State<PostUI> {
  late bool isLoading;
  late bool isShowEmoji;
  late Offset globalOffset;
  late bool isExpanded = false;
  late List<bool> emojiEnlarged = List.generate(7, (index) => false);

  @override
  void initState() {
    isLoading = false;
    isShowEmoji = false;
    globalOffset = Offset.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 5),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SkeletonWrapper(
                      enabled: isLoading,
                      child: CircleUserAvatar(
                          imageUrl: widget.post.author.avatar)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        widget.post.author.name,
                        style: themeData.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SkeletonWrapper(
                        enabled: isLoading,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            formatPostCreatedTime(widget.post.created),
                            style: themeData.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                        )),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(),
                            builder: (context) => Column(
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.notifications),
                                            const SizedBox(width: 10),
                                            Text(
                                                "Tắt thông báo về bài viết này",
                                                style: themeData
                                                    .textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.save),
                                            const SizedBox(width: 10),
                                            Text("Lưu bài viết",
                                                style: themeData
                                                    .textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.delete),
                                            const SizedBox(width: 10),
                                            Text("Xóa",
                                                style: themeData
                                                    .textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.edit),
                                            const SizedBox(width: 10),
                                            Text("Chỉnh sửa bài viết",
                                                style: themeData
                                                    .textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.link),
                                            const SizedBox(width: 10),
                                            Text(
                                                "Tắt thông báo về bài viết này",
                                                style: themeData
                                                    .textTheme.bodyLarge)
                                          ]),
                                        ))
                                  ],
                                ));
                      },
                      child: const Icon(Icons.more_horiz, color: Colors.grey)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SkeletonWrapper(
                enabled: isLoading,
                child: LayoutBuilder(builder: (context, size) {
                  var tp = TextPainter(
                    maxLines: isExpanded ? null : 5,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    text: formatPostDescribed(widget.post.described, themeData),
                  );
                  tp.layout(maxWidth: size.maxWidth);
                  var exceeded = tp.didExceedMaxLines;
                  if (exceeded) {
                    return Stack(children: <Widget>[
                      Text.rich(
                        formatPostDescribed(widget.post.described, themeData),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              color: themeData.colorScheme.surface,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  "...Xem thêm",
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                          color: themeData
                                              .colorScheme.inverseSurface,
                                          fontWeight: FontWeight.w500),
                                ),
                              )))
                    ]);
                  } else if (isExpanded) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text.rich(
                            formatPostDescribed(
                                widget.post.described, themeData),
                            maxLines: 10000000,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                              color: themeData.colorScheme.surface,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  "Thu gọn",
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                          color: themeData
                                              .colorScheme.inverseSurface,
                                          fontWeight: FontWeight.w500),
                                ),
                              ))
                        ]);
                  } else {
                    return Text.rich(
                      formatPostDescribed(widget.post.described, themeData),
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                }),
              ),
            ),
            if ((widget.post.image?.length ?? 0) > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridMediaView(
                      onClickMedia: (index) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PostMediaUI(post: widget.post)));
                      },
                      medias: List.generate(
                          widget.post.image?.length ?? 0,
                          (index) => Image.network(
                                widget.post.image![index].url,
                                fit: BoxFit.cover,
                              ))),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SkeletonWrapper(
                  enabled: isLoading,
                  child: Row(
                    children: [
                      const ReactionDisplay(),
                      Text(" ${widget.post.kudos + widget.post.disappointed}",
                          style: themeData.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300, color: Colors.grey)),
                      const Spacer(),
                      Text(
                          " ${(widget.post.fake + widget.post.trust).toString()} bình luận",
                          style: themeData.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300, color: Colors.grey)),
                    ],
                  )),
            ),
            const Divider(indent: 10, endIndent: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SkeletonWrapper(
                  enabled: isLoading,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onLongPressStart: (details) {
                          setState(() {
                            isShowEmoji = true;
                            emojiEnlarged = List.generate(7, (index) => false);
                            globalOffset = details.globalPosition;
                          });
                        },
                        onLongPressMoveUpdate: (details) {
                          setState(() {
                            globalOffset = details.globalPosition;
                          });
                        },
                        onLongPressCancel: () {
                          setState(() {
                            isShowEmoji = false;
                          });
                        },
                        onLongPressUp: () {
                          setState(() {
                            isShowEmoji = false;
                          });
                        },
                        onLongPressEnd: (details) {
                          setState(() {
                            isShowEmoji = false;
                          });
                        },
                        child: RichText(
                            text: TextSpan(
                                children: const [
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child:
                                      Icon(Icons.favorite, color: Colors.grey)),
                              TextSpan(text: " Thích")
                            ],
                                style: themeData.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey))),
                      ),
                      RichText(
                          text: TextSpan(
                              children: const [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.comment, color: Colors.grey)),
                            TextSpan(text: " Bình luận")
                          ],
                              style: themeData.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey))),
                      RichText(
                          text: TextSpan(
                              children: const [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(Icons.share, color: Colors.grey)),
                            TextSpan(text: " Chia sẻ")
                          ],
                              style: themeData.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey)))
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleUserAvatar(
                        imageUrl: widget.post.author.avatar, radius: 16),
                  ),
                  Expanded(
                      child: TextField(
                    inputFormatters: const [EmojiInputFormatter()],
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            gapPadding: 0),
                        hintText: "Viết bình luận...",
                        contentPadding:
                            const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        )),
                  ))
                ],
              ),
            ),
          ],
        ),
        if (isShowEmoji)
          Positioned(
            width: MediaQuery.sizeOf(context).width,
            bottom: 50,
            child: Center(
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(30),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/like.svg",
                            enlarged: emojiEnlarged[0],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[0] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/love.svg",
                            enlarged: emojiEnlarged[1],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[1] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/care.svg",
                            enlarged: emojiEnlarged[2],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[2] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/haha.svg",
                            enlarged: emojiEnlarged[3],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[3] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/sad.svg",
                            enlarged: emojiEnlarged[4],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[4] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/wow.svg",
                            enlarged: emojiEnlarged[5],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[5] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/angry.svg",
                            enlarged: emojiEnlarged[6],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[6] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _ReactionSliderItem extends StatelessWidget {
  final String assetIcon;
  final Offset globalOffset;
  final void Function(bool value) setEnlarged;
  final bool enlarged;
  const _ReactionSliderItem({
    super.key,
    required this.assetIcon,
    required this.globalOffset,
    required this.setEnlarged,
    required this.enlarged,
  });

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      var object = context.findRenderObject() as RenderBox?;
      Offset offset = object!.localToGlobal(Offset.zero);
      setEnlarged(offset.dx < globalOffset.dx &&
          offset.dx + (enlarged ? 70 : 40) > globalOffset.dx &&
          offset.dy < globalOffset.dy &&
          offset.dy + (enlarged ? 70 : 40) > globalOffset.dy);
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: enlarged ? EdgeInsets.zero : const EdgeInsets.all(0),
          child: SvgPicture.asset(assetIcon,
              width: enlarged ? 70 : 40, height: enlarged ? 70 : 40),
        ),
      ],
    );
  }
}
