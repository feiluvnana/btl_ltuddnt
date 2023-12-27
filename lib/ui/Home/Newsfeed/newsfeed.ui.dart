import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_create.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsfeedUI extends ConsumerStatefulWidget {
  const NewsfeedUI({super.key});

  static final ctrl = ScrollController();

  @override
  ConsumerState<NewsfeedUI> createState() => _NewsfeedUIState();
}

class _NewsfeedUIState extends ConsumerState<NewsfeedUI> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    NewsfeedUI.ctrl.addListener(() {
      if (NewsfeedUI.ctrl.offset >=
          NewsfeedUI.ctrl.position.maxScrollExtent - MediaQuery.sizeOf(context).height / 2) {
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
                  var index = posts?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
                  if (index == -1) return null;
                  return index;
                },
                addAutomaticKeepAlives: false,
                controller: NewsfeedUI.ctrl,
                itemBuilder: (context, index) => index == 0
                    ? const CreatePostBar()
                    : PostItem(
                        key: ValueKey<int>(posts![index - 1].id),
                        type: PostType.feed,
                        post: posts[index - 1]),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AFBCircleAvatar(
                    imageUrl: ref
                            .watch(
                                profileControllerProvider.select((value) => value.value?.profile))
                            ?.avatar ??
                        "")),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const PostCreateUI()));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all()),
                  child: const Text("Bạn đang nghĩ gì?"),
                ),
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        ...List.generate(
            ref
                    .watch(
                        newsfeedControllerProvider.select((value) => value.value?.postingProgress))
                    ?.length ??
                0, (index) {
          var data = ref
              .watch(newsfeedControllerProvider.select((value) => value.value?.postingProgress))
              ?.entries
              .elementAt(index);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(data!.key), LinearProgressIndicator(value: data.value)],
          );
        })
      ],
    );
  }
}
