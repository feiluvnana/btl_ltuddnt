// ignore_for_file: unused_element

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/skeleton_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                SkeletonWrapper(enabled: isLoading, child: const _PostAuthor()),
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
          child:
              SkeletonWrapper(enabled: isLoading, child: const _PostReaction()),
        ),
        const Divider(indent: 10, endIndent: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SkeletonWrapper(
              enabled: isLoading, child: const _PostInteraction()),
        ),
      ],
    );
  }
}

class _PostInteraction extends StatelessWidget {
  const _PostInteraction();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
            text: TextSpan(
                children: const [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.favorite, color: Colors.grey)),
              TextSpan(text: " Thích")
            ],
                style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.grey))),
        RichText(
            text: TextSpan(
                children: const [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.comment, color: Colors.grey)),
              TextSpan(text: " Bình luận")
            ],
                style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.grey))),
        RichText(
            text: TextSpan(
                children: const [
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.share, color: Colors.grey)),
              TextSpan(text: " Chia sẻ")
            ],
                style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.grey)))
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
        SvgPicture.asset("assets/emojis/like.svg", width: 18, height: 18),
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
