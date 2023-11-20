import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/reaction_display.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class DetailImageView extends StatefulWidget {
  final Post? post;
  final int initIndex;

  const DetailImageView({super.key, this.post, this.initIndex = 0});

  @override
  State<DetailImageView> createState() => _DetailImageViewState();
}

class _DetailImageViewState extends State<DetailImageView> {
  bool isExpanded = false;
  late final PageController ctrl = PageController(initialPage: widget.initIndex);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: TransparentAppBar(
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back,
                color: themeData.canvasColor,
              ))),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: ctrl,
            itemBuilder: (context, index) => InteractiveViewer(
              child: Image.network(
                widget.post!.image![index].url,
                fit: BoxFit.contain,
              ),
            ),
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
                        style: themeData.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold, color: themeData.canvasColor),
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
                                  ?.copyWith(color: themeData.canvasColor),
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
                                      ?.copyWith(color: themeData.canvasColor),
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
                                fontWeight: FontWeight.bold, color: themeData.canvasColor),
                          );
                        }
                      }),
                      const SizedBox(height: 5),
                      Text(
                        formatPostCreatedTime(widget.post!.created).toUpperCase(),
                        style: themeData.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          // ReactionDisplay(
                          //   kudos: widget.post!.kudos,
                          //   dissapointed: widget.post!.disappointed,
                          // ),
                          // Text(" ${widget.post!.kudos + widget.post!.disappointed}",
                          //     style: themeData.textTheme.bodySmall
                          //         ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                          // const Spacer(),
                          // Text(" ${(widget.post!.fake + widget.post!.trust).toString()} bình luận",
                          //     style: themeData.textTheme.bodySmall
                          //         ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
                        ],
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
