import 'dart:math';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_image.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';

class PostDetailMediaUI extends StatefulWidget {
  final Post? post;
  final int initIndex;

  const PostDetailMediaUI({super.key, this.post, this.initIndex = 0});

  @override
  State<PostDetailMediaUI> createState() => _PostDetailMediaUIState();
}

class _PostDetailMediaUIState extends State<PostDetailMediaUI> {
  bool isExpanded = false;
  double scale = 1;
  double baseScale = 1;
  late final PageController ctrl = PageController(initialPage: widget.initIndex);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back))),
      body: Stack(
        children: [
          PageView.builder(
            controller: ctrl,
            physics: baseScale == 1 ? null : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InteractiveViewer(
                minScale: 1,
                onInteractionUpdate: (details) {
                  scale = baseScale * details.scale;
                },
                onInteractionEnd: (details) {
                  setState(() {
                    baseScale = max(scale, 1);
                  });
                },
                child: AFBNetworkImage(
                  url: widget.post!.image![index].url,
                  fit: BoxFit.contain,
                )),
            itemCount: widget.post?.image?.length ?? 0,
          ),
          if (widget.post != null)
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(8.0),
                width: MediaQuery.sizeOf(context).width,
                constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height / 3),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.post!.author.name,
                        style: themeData.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: themeData.colorScheme.onPrimary),
                      ),
                      LayoutBuilder(builder: (context, size) {
                        var tp = TextPainter(
                          maxLines: isExpanded ? null : 5,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          text: formatPostDescribed(widget.post!.described, themeData),
                        );
                        tp.layout(maxWidth: size.maxWidth);
                        var exceeded = tp.didExceedMaxLines;
                        if (exceeded) {
                          return Stack(children: <Widget>[
                            Text.rich(
                              formatPostDescribed(widget.post!.described, themeData),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: themeData.textTheme.bodyMedium
                                  ?.copyWith(color: themeData.colorScheme.onPrimary),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    color: Colors.black,
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
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text.rich(
                                  formatPostDescribed(widget.post!.described, themeData),
                                  maxLines: 10000000,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(color: themeData.colorScheme.onPrimary),
                                ),
                                GestureDetector(
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
                                )
                              ]);
                        } else {
                          return Text.rich(
                            formatPostDescribed(widget.post!.described, themeData),
                            overflow: TextOverflow.ellipsis,
                            style: themeData.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: themeData.colorScheme.onPrimary),
                          );
                        }
                      }),
                      const SizedBox(height: 5),
                      Text(
                        formatCreatedTime(widget.post!.created).toUpperCase(),
                        style: themeData.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      const Divider(thickness: 5),
                      const Row(
                        children: [],
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}