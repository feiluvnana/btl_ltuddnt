import 'dart:math';

import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/controllers/watch.controller.dart';
import 'package:Anti_Fakebook/data/data.dart';
import 'package:Anti_Fakebook/helpers/emoji.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/helpers/mark.dart';
import 'package:Anti_Fakebook/helpers/text_formater.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/mark.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_detail_media.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_media.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_modify.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Report/post_report_ui.dart';
import 'package:Anti_Fakebook/ui/Home/Profile/profile.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Profile/profile_query.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_expandable_text.dart';
import 'package:Anti_Fakebook/widgets/afb_grid_image_view.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_video_player.dart';
import 'package:Anti_Fakebook/widgets/afb_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PostType { feed, watch, profile, search }

class PostItem extends ConsumerStatefulWidget {
  final Post post;
  final PostType type;

  const PostItem({super.key, required this.post, required this.type});

  @override
  ConsumerState<PostItem> createState() => _PostItemState();
}

class _PostItemState extends ConsumerState<PostItem> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    var profile = ref.watch(profileControllerProvider.select((value) => value.value?.profile));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 5),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: AFBCircleAvatar(imageUrl: widget.post.author.avatar),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (profile?.id == widget.post.author.id) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const ProfileUI()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileQueryUI(userId: widget.post.author.id)));
                    }
                  },
                  child: Text(
                    widget.post.author.name,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 4 * 3,
                  child: Builder(builder: (context) {
                    final data = processedData.firstWhere((e) => e["name"] == widget.post.state,
                        orElse: () => {"uri": "Không rõ"});
                    return Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: formatPostCreatedTime(widget.post.created),
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                        TextSpan(
                            text: " - đang cảm thấy ",
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                        WidgetSpan(
                            child: data["uri"] == "Không rõ"
                                ? Text("\ufffd",
                                    style: themeData.textTheme.bodySmall?.copyWith(fontSize: 8))
                                : AFBNetworkImage(
                                    url: processedData
                                        .firstWhere((e) => e["name"] == widget.post.state)["uri"],
                                    width: themeData.textTheme.bodySmall?.fontSize,
                                  ),
                            alignment: PlaceholderAlignment.middle),
                        TextSpan(
                            text: " ",
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                        TextSpan(
                            text: widget.post.state,
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    debugPrint(widget.post.toJson().toString());
                    context.showAFBOptionModalBottomSheet(blocks: [
                      [
                        AFBBottomSheetListTile(
                            onTap: () {}, leading: Icons.save, title: "Lưu bài viết"),
                        if (profile?.id == widget.post.author.id &&
                            widget.type != PostType.watch &&
                            widget.type != PostType.search)
                          AFBBottomSheetListTile(
                              onTap: () {
                                context.showAFBDialog<bool>(
                                  title:
                                      Text("Xóa bài viết?", style: themeData.textTheme.bodyLarge),
                                  content:
                                      const Text("Bạn có thể chỉnh sửa bài viết nếu cần thay đổi."),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                          ..read(newsfeedControllerProvider.notifier)
                                              .deletePost(id: widget.post.id)
                                          ..read(profileControllerProvider.notifier)
                                              .deletePost(id: widget.post.id)
                                          ..read(watchControllerProvider.notifier)
                                              .deletePost(id: widget.post.id);

                                        Navigator.maybePop(context);
                                        Navigator.maybePop(context);
                                      },
                                      child: Text("XÓA",
                                          style: themeData.textTheme.bodyMedium
                                              ?.copyWith(color: themeData.colorScheme.primary)),
                                    ),
                                    GestureDetector(
                                        onTap: () => Navigator.maybePop(context).whenComplete(() =>
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PostModifyUI(post: widget.post)))),
                                        child: const Text("CHỈNH SỬA")),
                                    GestureDetector(
                                        onTap: () => Navigator.maybePop(context),
                                        child: const Text("HỦY")),
                                  ],
                                );
                              },
                              leading: Icons.delete,
                              title: "Xóa bài viết"),
                        if (profile?.id == widget.post.author.id &&
                            widget.type != PostType.watch &&
                            widget.type != PostType.search)
                          AFBBottomSheetListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostModifyUI(post: widget.post)));
                              },
                              leading: Icons.edit,
                              title: "Chỉnh sửa bài viết")
                      ],
                      [
                        AFBBottomSheetListTile(
                            onTap: () {},
                            leading: Icons.notifications,
                            title: "Tắt thông báo về bài viết này"),
                        if (profile?.id != widget.post.author.id)
                          AFBBottomSheetListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostReportUI(post: widget.post)));
                              },
                              leading: Icons.feedback,
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
          child: AFBExpandableText(text: widget.post.described),
        ),
        if (getFirstLink(widget.post.described) != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: AFBWebPreview(url: getFirstLink(widget.post.described)!),
          ),
        if (widget.post.image?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: AFBGridImageView(
                  onClickMedia: (index) {
                    if (widget.post.image?.length == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetailMediaUI(post: widget.post)));
                      return;
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostMediaUI(post: widget.post)));
                  },
                  medias: List.generate(
                      widget.post.image?.length ?? 0,
                      (index) => AFBNetworkImage(
                            url: widget.post.image![index].url,
                            fit: BoxFit.cover,
                            reduceQuality: true,
                          ))),
            ),
          ),
        if (widget.post.video != null)
          SizedBox(child: AFBVideoPlayer(url: widget.post.video!.url ?? "")),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                  " ${max(widget.post.feel, widget.post.kudos + widget.post.disappointed)} lượt feel",
                  style: themeData.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
              const Spacer(),
              Text(
                  " ${max(widget.post.commentMark, widget.post.trust + widget.post.fake)} mark/bình luận",
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
                onTap: () {
                  ref
                    ..read(newsfeedControllerProvider.notifier).feelPost(post: widget.post, type: 1)
                    ..read(profileControllerProvider.notifier).feelPost(post: widget.post, type: 1)
                    ..read(watchControllerProvider.notifier).feelPost(post: widget.post, type: 1);
                },
                child: RichText(
                    text: TextSpan(
                  children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(Icons.favorite,
                            color: widget.post.isFelt != FeelType.kudos
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary)),
                    TextSpan(
                        text: "Kudos",
                        style: themeData.textTheme.bodyMedium?.copyWith(
                            color: widget.post.isFelt != FeelType.kudos
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary))
                  ],
                )),
              ),
              GestureDetector(
                onTap: () {
                  ref
                    ..read(newsfeedControllerProvider.notifier).feelPost(post: widget.post, type: 0)
                    ..read(profileControllerProvider.notifier).feelPost(post: widget.post, type: 0)
                    ..read(watchControllerProvider.notifier).feelPost(post: widget.post, type: 0);
                },
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(Icons.heart_broken,
                          color: widget.post.isFelt != FeelType.dissapointed
                              ? Colors.grey
                              : Theme.of(context).colorScheme.error)),
                  TextSpan(
                      text: "Dissapointed",
                      style: themeData.textTheme.bodyMedium?.copyWith(
                          color: widget.post.isFelt != FeelType.dissapointed
                              ? Colors.grey
                              : Theme.of(context).colorScheme.error))
                ])),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      isScrollControlled: false,
                      scrollControlDisabledMaxHeightRatio: 0.9,
                      context: context,
                      builder: (context) {
                        return MarkUI(postId: widget.post.id);
                      });
                },
                child: RichText(
                    text: TextSpan(
                        children: const [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(Icons.chat_bubble, color: Colors.grey)),
                      TextSpan(text: " Mark")
                    ],
                        style: themeData.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey))),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkTextField(postId: widget.post.id),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MarkTextField extends ConsumerStatefulWidget {
  const MarkTextField({super.key, required this.postId});

  final int postId;

  @override
  ConsumerState<MarkTextField> createState() => _MarkTextFieldState();
}

class _MarkTextFieldState extends ConsumerState<MarkTextField> {
  final ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AFBCircleAvatar(
              imageUrl: ref.watch(profileControllerProvider).value?.profile?.avatar ?? ""),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), gapPadding: 0),
              hintText: "[T/F]<Nội dung mark>",
              contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
              suffixIcon: IconButton(
                onPressed: !validateMarkSyntax(ctrl.text)
                    ? null
                    : () {
                        ref.read(newsfeedControllerProvider.notifier).setMarkComment(
                            widget.postId, ctrl.text.substring(3),
                            type: getTypeFromMarkSyntax(ctrl.text));
                        ctrl.text = "";
                      },
                icon: Icon(Icons.send,
                    color: !validateMarkSyntax(ctrl.text) ? null : themeData.colorScheme.primary),
              )),
        ))
      ],
    );
  }
}
