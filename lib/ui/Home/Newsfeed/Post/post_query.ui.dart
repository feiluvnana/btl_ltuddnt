import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/helpers/text_formater.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/feel.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/mark.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_detail_media.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_expandable_text.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_shimmer.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostQueryUI extends ConsumerStatefulWidget {
  final int postId;

  const PostQueryUI({super.key, required this.postId});

  @override
  ConsumerState<PostQueryUI> createState() => _PostQueryUIState();
}

class _PostQueryUIState extends ConsumerState<PostQueryUI> {
  late Future<List<Post>> _getPostFuture;

  @override
  void initState() {
    _getPostFuture = ref.read(newsfeedControllerProvider.notifier).getPost(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return FutureBuilder<List<Post>>(
        future: _getPostFuture,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AFBAppBar(
              title: Text(
                  snapshot.data?.isNotEmpty == true ? snapshot.data!.first.described : "Bài viết",
                  style: themeData.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              leading: IconButton(
                  onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
            ),
            body: (snapshot.data == [])
                ? const Center(
                    child: Text("Người dùng không tồn tại hoặc bạn không thể xem người dùng này."))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(thickness: 5),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: AFBShimmer(
                                  enabled: snapshot.data == null,
                                  child: AFBCircleAvatar(
                                      imageUrl: snapshot.data?.first.author.avatar ?? "")),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AFBShimmer(
                                    enabled: snapshot.data == null,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        snapshot.data?.first.author.name ?? "Author's name",
                                        style: themeData.textTheme.bodyMedium
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                AFBShimmer(
                                    enabled: snapshot.data == null,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        formatPostCreatedTime(
                                            snapshot.data?.first.created ?? DateTime.now()),
                                        style: themeData.textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w300, color: Colors.grey),
                                      ),
                                    )),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    context.showAFBOptionModalBottomSheet(blocks: [
                                      [
                                        AFBBottomSheetListTile(
                                            onTap: () {},
                                            leading: Icons.notifications,
                                            title: "Tắt thông báo về bài viết này"),
                                        AFBBottomSheetListTile(
                                            onTap: () {},
                                            leading: Icons.save,
                                            title: "Lưu bài viết"),
                                        AFBBottomSheetListTile(
                                            onTap: () {},
                                            leading: Icons.link,
                                            title: "Sao chép liên kết"),
                                      ]
                                    ]);
                                  },
                                  child: const Icon(Icons.more_horiz, color: Colors.grey)),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: AFBShimmer(
                                enabled: snapshot.data == null,
                                child: AFBExpandableText(
                                    text: snapshot.data?.first.described ?? "Described"))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: AFBShimmer(
                              enabled: snapshot.data == null,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)),
                                          isScrollControlled: false,
                                          scrollControlDisabledMaxHeightRatio: 0.9,
                                          context: context,
                                          builder: (context) {
                                            return FeelUI(postId: snapshot.data!.first.id);
                                          });
                                    },
                                    child: Text(
                                        "${snapshot.data?.first.kudos} lượt kudos\n${snapshot.data?.first.disappointed} lượt dissapointed",
                                        style: themeData.textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w300, color: Colors.grey)),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)),
                                          isScrollControlled: false,
                                          scrollControlDisabledMaxHeightRatio: 0.9,
                                          context: context,
                                          builder: (context) {
                                            return MarkUI(postId: snapshot.data!.first.id);
                                          });
                                    },
                                    child: Text(
                                        "${snapshot.data?.first.trust} mark trust\n${snapshot.data?.first.fake} mark fake",
                                        style: themeData.textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w300, color: Colors.grey)),
                                  ),
                                ],
                              )),
                        ),
                        const Divider(indent: 10, endIndent: 10),
                        ...List.generate(
                            snapshot.data?.first.image?.length ?? 0,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PostDetailMediaUI(
                                                  post: snapshot.data?.first,
                                                  initIndex: index,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AFBNetworkImage(
                                      url: snapshot.data!.first.image![index].url,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.sizeOf(context).width,
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
          );
        });
  }
}
