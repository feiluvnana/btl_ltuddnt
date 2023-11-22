import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Create&Update/post_create_update_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Report/post_report_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/post_media_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/emoji.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_webview.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/expandable_text.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/media_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostUI extends StatefulWidget {
  final Post post;

  const PostUI({super.key, required this.post});

  @override
  State<PostUI> createState() => _PostUIState();
}

class _PostUIState extends State<PostUI> with AutomaticKeepAliveClientMixin {
  late bool isShowEmoji;
  late Offset globalOffset;
  late List<bool> emojiEnlarged = List.generate(2, (index) => false);

  @override
  void initState() {
    isShowEmoji = false;
    globalOffset = Offset.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  child: CircularUserAvatar(imageUrl: widget.post.author.avatar),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        widget.post.author.name,
                        style:
                            themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        formatPostCreatedTime(widget.post.created),
                        style: themeData.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                      onTap: () {
                        showAFBModalBottomSheet(context: context, blocks: [
                          [
                            AFBBottomSheetListTile(
                                onTap: () {}, leading: Icons.save, title: "Lưu bài viết"),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  showAFBDialog<bool>(
                                    context: context,
                                    title:
                                        Text("Xóa bài viết?", style: themeData.textTheme.bodyLarge),
                                    content: const Text(
                                        "Bạn có thể chỉnh sửa bài viết nếu cần thay đổi."),
                                    actions: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<NewsfeedBloc>()
                                              .add(NewsfeedDeletePost(id: widget.post.id));
                                          Navigator.maybePop(context);
                                          Navigator.maybePop(context);
                                        },
                                        child: Text("XÓA",
                                            style: themeData.textTheme.bodyMedium
                                                ?.copyWith(color: themeData.primaryColor)),
                                      ),
                                      GestureDetector(
                                          onTap: () => Navigator.maybePop(context).whenComplete(
                                              () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostCreateUpdateUI(post: widget.post)))),
                                          child: const Text("CHỈNH SỬA")),
                                      GestureDetector(
                                          onTap: () => Navigator.maybePop(context),
                                          child: const Text("HỦY")),
                                    ],
                                  );
                                },
                                leading: Icons.delete,
                                title: "Xóa bài viết"),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostCreateUpdateUI(
                                                post: widget.post,
                                              )));
                                },
                                leading: Icons.edit,
                                title: "Chỉnh sửa bài viết")
                          ],
                          [
                            AFBBottomSheetListTile(
                                onTap: () {},
                                leading: Icons.notifications,
                                title: "Tắt thông báo về bài viết này"),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostReportUI(post: widget.post)));
                                },
                                leading: Icons.report,
                                title: "Báo cáo bài viết"),
                            AFBBottomSheetListTile(
                                onTap: () {}, leading: Icons.link, title: "Sao chép liên kết")
                          ]
                        ]);
                      },
                      child: const Icon(Icons.more_horiz, color: Colors.grey)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ExpandableText(post: widget.post),
            ),
            if (getFirstLink(widget.post.described) != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: AFBWebPreview(url: getFirstLink(widget.post.described)!),
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
                                builder: (context) => PostMediaUI(post: widget.post)));
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
              child: Row(
                children: [
                  // ReactionDisplay(
                  //   kudos: widget.post.kudos,
                  //   dissapointed: widget.post.disappointed,
                  // ),
                  Text(" ${widget.post.feel} lượt feel",
                      style: themeData.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                  const Spacer(),
                  Text(" ${(widget.post.commentMark)} bình luận",
                      style: themeData.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                ],
              ),
            ),
            const Divider(indent: 10, endIndent: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              child: Icon(Icons.favorite, color: Colors.grey)),
                          TextSpan(text: " Thích")
                        ],
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey))),
                  ),
                  RichText(
                      text: TextSpan(
                          children: const [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(Icons.add_comment, color: Colors.grey)),
                        TextSpan(text: " Bình luận")
                      ],
                          style: themeData.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircularUserAvatar(imageUrl: widget.post.author.avatar),
                  ),
                  Expanded(
                      child: TextField(
                    inputFormatters: const [EmojiInputFormatter()],
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20), gapPadding: 0),
                        hintText: "Viết bình luận...",
                        contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
            bottom: 100,
            child: Center(
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(30),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  decoration: BoxDecoration(color: themeData.canvasColor),
                  child: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/haha.svg",
                            enlarged: emojiEnlarged[0],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[0] = value;
                              });
                            },
                            globalOffset: globalOffset,
                          ),
                          _ReactionSliderItem(
                            assetIcon: "assets/emojis/sad.svg",
                            enlarged: emojiEnlarged[1],
                            setEnlarged: (value) {
                              setState(() {
                                emojiEnlarged[1] = value;
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

  @override
  bool get wantKeepAlive => true;
}

class _ReactionSliderItem extends StatelessWidget {
  final String assetIcon;
  final Offset globalOffset;
  final void Function(bool value) setEnlarged;
  final bool enlarged;
  const _ReactionSliderItem({
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
          child: SvgPicture.asset(assetIcon, width: enlarged ? 70 : 40, height: enlarged ? 70 : 40),
        ),
      ],
    );
  }
}
