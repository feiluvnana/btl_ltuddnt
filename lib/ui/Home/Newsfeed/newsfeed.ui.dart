import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Post/post_create_modify.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsfeedUI extends ConsumerStatefulWidget {
  const NewsfeedUI({super.key});

  @override
  ConsumerState<NewsfeedUI> createState() => _NewsfeedUIState();
}

class _NewsfeedUIState extends ConsumerState<NewsfeedUI> with AutomaticKeepAliveClientMixin {
  final ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent) {
        ref.read(newsfeedControllerProvider.notifier).getPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(newsfeedControllerProvider.notifier).refresh();
      },
      child: Builder(
        builder: (context) {
          final posts = ref.watch(newsfeedControllerProvider.select((value) => value.value?.posts));
          return switch (posts?.isEmpty) {
            null => const Column(
                children: [
                  CreatePostBar(),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
                ],
              ),
            false => ListView.builder(
                findChildIndexCallback: (key) {
                  return posts!.indexWhere((element) => (key as ObjectKey).value == element.id) + 1;
                },
                controller: ctrl,
                itemBuilder: (context, index) => index == 0
                    ? const CreatePostBar()
                    : PostItem(key: ObjectKey(posts![index - 1].id), post: posts[index - 1]),
                itemCount: (posts?.length ?? 0) + 1),
            true => const Column(
                children: [
                  CreatePostBar(),
                  Center(child: Text("Không có bài viết...")),
                ],
              )
          };
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CreatePostBar extends ConsumerWidget {
  const CreatePostBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: AFBCircleAvatar(
                imageUrl: ref
                        .watch(authenControllerProvider.select((value) => value.value?.user))
                        ?.avatar ??
                    "")),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const PostCreateModifyUI()));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()),
              child: const Text("Bạn đang nghĩ gì?"),
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
