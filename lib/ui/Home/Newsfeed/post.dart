// ignore_for_file: unused_element

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/skeleton_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late bool isLoading;
  late bool isShowEmoji;
  late Offset globalOffset;
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SkeletonWrapper(
                      enabled: isLoading, child: const CircleUserAvatar()),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonWrapper(
                        enabled: isLoading, child: const _PostAuthor()),
                    SkeletonWrapper(
                        enabled: isLoading,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [_PostTime(), _PostPrivacy()],
                        )),
                  ],
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SkeletonWrapper(
                        enabled: isLoading, child: const _PostAction())),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SkeletonWrapper(
                  enabled: isLoading, child: const _PostTextContent()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SkeletonWrapper(
                  enabled: isLoading, child: const _PostReaction()),
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

class _PostReaction extends StatelessWidget {
  const _PostReaction();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        _ReactionDisplay(),
        Text(" 18",
            style: themeData.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
        const Spacer(),
        Text(" 18 bình luận • 18 lượt chia sẻ",
            style: themeData.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey)),
      ],
    );
  }
}

class _ReactionDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20 + 32,
      height: 20,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset("assets/emojis/like.svg",
                width: 20, height: 20),
          ),
          Positioned(
            left: 16,
            child: SvgPicture.asset("assets/emojis/love.svg",
                width: 20, height: 20),
          ),
          Positioned(
            left: 32,
            child: SvgPicture.asset("assets/emojis/haha.svg",
                width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}

class _PostTextContent extends StatelessWidget {
  final String? content;

  const _PostTextContent({this.content});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Text(
      content ??
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      style: themeData.textTheme.bodyMedium,
    );
  }
}

class _PostAuthor extends StatelessWidget {
  final String? author;

  const _PostAuthor({this.author});

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

class _PostTime extends StatelessWidget {
  final String? time;

  const _PostTime({this.time});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Text(
        time ?? "Time Placeholder • ",
        style: themeData.textTheme.bodySmall
            ?.copyWith(fontWeight: FontWeight.w300, color: Colors.grey),
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {},
            child: const Icon(Icons.more_horiz, color: Colors.grey)),
        const SizedBox(width: 10),
        GestureDetector(
            onTap: () {},
            child: const Icon(Icons.cancel_outlined, color: Colors.grey)),
      ],
    );
  }
}

class _PostPrivacy extends StatelessWidget {
  const _PostPrivacy();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Icon(Icons.public,
        color: Colors.grey, size: themeData.textTheme.bodySmall?.fontSize);
  }
}
