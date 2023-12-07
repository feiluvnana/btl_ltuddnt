import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/watch.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchUI extends ConsumerStatefulWidget {
  const WatchUI({super.key});

  @override
  ConsumerState<WatchUI> createState() => _WatchUIState();
}

class _WatchUIState extends ConsumerState<WatchUI> {
  final ctrl = ScrollController();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent) {
        ref.read(watchControllerProvider.notifier).getVideos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(watchControllerProvider.notifier).refresh();
      },
      child: Builder(
        builder: (context) {
          final videos = ref.watch(watchControllerProvider.select((value) => value.value?.videos));
          return switch (videos?.isEmpty) {
            null => const Center(
                child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator())),
            false => ListView.builder(
                findChildIndexCallback: (key) {
                  var index = videos?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
                  if (index == -1) return null;
                  return index;
                },
                controller: ctrl,
                itemBuilder: (context, index) =>
                    PostItem(key: ValueKey<int>(videos![index].id), post: videos[index]),
                itemCount: videos?.length ?? 0),
            true => const Center(child: Text("Không có bài viết..."))
          };
        },
      ),
    );
  }
}
