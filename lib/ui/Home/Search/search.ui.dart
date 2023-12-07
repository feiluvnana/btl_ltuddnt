import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/search.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/keyword.model.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUI extends ConsumerStatefulWidget {
  const SearchUI({super.key});

  @override
  ConsumerState<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends ConsumerState<SearchUI> {
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PopScope(
      onPopInvoked: (didPop) => ref.read(searchControllerProvider.notifier).deleteResult(),
      child: Scaffold(
        appBar: AFBAppBar(
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
                controller: ctrl,
                onSubmitted: (value) => ref.read(searchControllerProvider.notifier).search(value),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          ref.read(searchControllerProvider.notifier).deleteResult();
                          ctrl.clear();
                          setState(() {});
                        },
                        child: const Icon(Icons.close)),
                    hintText: "Tìm kiếm",
                    filled: true,
                    border: InputBorder.none,
                    fillColor: themeData.colorScheme.onInverseSurface)),
          ),
        ),
        body: Builder(builder: (context) {
          var posts =
              ref.watch(searchControllerProvider.select((value) => value.value?.searchResult));
          var keywords =
              ref.watch(searchControllerProvider.select((value) => value.value?.keywords));
          return (posts?.isEmpty == true)
              ? const Center(child: Text("Không có dữ liệu"))
              : (posts?.isEmpty == false)
                  ? ListView.builder(
                      findChildIndexCallback: (key) {
                        var index = posts?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
                        if (index == -1) return null;
                        return index;
                      },
                      itemBuilder: (context, index) =>
                          PostItem(key: ValueKey<int>(posts![index].id), post: posts[index]),
                      itemCount: posts?.length ?? 0)
                  : (keywords?.isNotEmpty == true)
                      ? ListView.builder(
                          itemBuilder: (context, index) => KeywordItem(keyword: keywords![index]),
                          itemCount: keywords?.length ?? 0)
                      : const Center(child: Text("Hãy tìm kiếm gì đó"));
        }),
      ),
    );
  }
}

class KeywordItem extends ConsumerWidget {
  final Keyword keyword;
  const KeywordItem({required this.keyword, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(keyword.keyword),
      onTap: () => ref.read(searchControllerProvider.notifier).search(keyword.keyword),
      trailing: IconButton(
          onPressed: () {
            ref.read(searchControllerProvider.notifier).deleteSearch(keyword.id);
          },
          icon: const Icon(Icons.close)),
    );
  }
}
