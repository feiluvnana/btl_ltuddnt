// ignore_for_file: unused_element

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/detail_image_view.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/reaction_display.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/skeleton_wrapper.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class PostMediaUI extends StatefulWidget {
  final Post post;

  const PostMediaUI({super.key, required this.post});

  @override
  State<PostMediaUI> createState() => _PostMediaUIState();
}

class _PostMediaUIState extends State<PostMediaUI> {
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
    return Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Bài viết",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 5),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SkeletonWrapper(
                      enabled: isLoading,
                      child: CircleUserAvatar(imageUrl: widget.post.author.avatar)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonWrapper(
                        enabled: isLoading,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            widget.post.author.name,
                            style: themeData.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                    SkeletonWrapper(
                        enabled: isLoading,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            formatPostCreatedTime(widget.post.created),
                            style: themeData.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey),
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
                                            Text("Tắt thông báo về bài viết này",
                                                style: themeData.textTheme.bodyLarge)
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
                                                style: themeData.textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.delete),
                                            const SizedBox(width: 10),
                                            Text("Xóa", style: themeData.textTheme.bodyLarge)
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
                                                style: themeData.textTheme.bodyLarge)
                                          ]),
                                        )),
                                    InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            const Icon(Icons.link),
                                            const SizedBox(width: 10),
                                            Text("Tắt thông báo về bài viết này",
                                                style: themeData.textTheme.bodyLarge)
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
                                  style: themeData.textTheme.bodyMedium?.copyWith(
                                      color: themeData.colorScheme.inverseSurface,
                                      fontWeight: FontWeight.w500),
                                ),
                              )))
                    ]);
                  } else if (isExpanded) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text.rich(
                        formatPostDescribed(widget.post.described, themeData),
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
                              style: themeData.textTheme.bodyMedium?.copyWith(
                                  color: themeData.colorScheme.inverseSurface,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SkeletonWrapper(
                  enabled: isLoading,
                  child: Row(
                    children: [
                      // ReactionDisplay(
                      //   kudos: widget.post.kudos,
                      //   dissapointed: widget.post.disappointed,
                      // ),
                      // Text(" ${widget.post.kudos + widget.post.disappointed}",
                      //     style: themeData.textTheme.bodySmall
                      //         ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                      // const Spacer(),
                      // Text(" ${(widget.post.fake + widget.post.trust).toString()} bình luận",
                      //     style: themeData.textTheme.bodySmall
                      //         ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                    ],
                  )),
            ),
            const Divider(indent: 10, endIndent: 10),
            ...List.generate(
                widget.post.image?.length ?? 0,
                (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailImageView(
                                      post: widget.post,
                                      initIndex: index,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.post.image![index].url,
                          fit: BoxFit.cover,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
