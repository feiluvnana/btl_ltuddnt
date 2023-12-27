import 'package:Anti_Fakebook/controllers/search.controller.dart';
import 'package:Anti_Fakebook/models/friend.dart';
import 'package:Anti_Fakebook/models/keyword.model.dart';
import 'package:Anti_Fakebook/models/post.dart';
import 'package:Anti_Fakebook/ui/Home/Friend/friend_all.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_item.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUI extends ConsumerStatefulWidget {
  const SearchUI({super.key});

  @override
  ConsumerState<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends ConsumerState<SearchUI> with TickerProviderStateMixin {
  final keyword = TextEditingController();
  late final ctrl = TabController(length: 2, vsync: this);
  bool isLoading = false;
  List<Post>? posts;
  List<Friend>? users;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        keyword.text = ModalRoute.of(context)!.settings.arguments.toString();
        search(ModalRoute.of(context)!.settings.arguments.toString());
      });
    }
  }

  void search(String keyword) {
    setState(() {
      isLoading = true;
      posts = null;
      users = null;
    });
    ref.read(searchControllerProvider.notifier).search(keyword).then((value) => setState(() {
          posts = value;
          isLoading = false;
        }));
    ref.read(searchControllerProvider.notifier).searchUser(keyword).then((value) => setState(() {
          users = value;
          isLoading = false;
        }));
    ref.read(searchControllerProvider.notifier).updateSavedSearch();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextField(
              controller: keyword,
              onSubmitted: search,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        keyword.clear();
                        setState(() {
                          posts = users = null;
                        });
                      },
                      child: const Icon(Icons.close)),
                  hintText: "Tìm kiếm",
                  filled: true,
                  border: InputBorder.none,
                  fillColor: themeData.colorScheme.onInverseSurface)),
        ),
      ),
      body: Column(
        children: [
          if (users != null && posts != null)
            TabBar(
                controller: ctrl,
                tabs: const [Tab(child: Text("Bài viết")), Tab(child: Text("Người dùng"))]),
          Expanded(
            child: (isLoading)
                ? const Center(child: Text("Đang tải..."))
                : (users != null && posts != null)
                    ? TabBarView(controller: ctrl, children: [
                        (posts!.isEmpty == true)
                            ? const Center(child: Text("Không có dữ liệu"))
                            : ListView.builder(
                                findChildIndexCallback: (key) {
                                  var index = posts
                                      ?.indexWhere((e) => e.id == (key as ValueKey<int>).value);
                                  if (index == -1) return null;
                                  return index;
                                },
                                itemBuilder: (context, index) => PostItem(
                                    key: ValueKey<int>(posts![index].id),
                                    type: PostType.search,
                                    post: posts![index]),
                                itemCount: posts!.length),
                        (users!.isEmpty == true)
                            ? const Center(child: Text("Không có dữ liệu"))
                            : ListView.builder(
                                itemBuilder: (context, index) =>
                                    FriendAllItem(friend: users![index], noOptions: true),
                                itemCount: users!.length),
                      ])
                    : Builder(builder: (context) {
                        var keywords = ref.watch(
                            searchControllerProvider.select((value) => value.value?.keywords));
                        return (keywords?.isNotEmpty == true)
                            ? ListView.builder(
                                itemBuilder: (context, index) => KeywordItem(
                                      keyword: keywords![index],
                                      onTap: () {
                                        ref
                                            .read(searchControllerProvider.notifier)
                                            .search(keywords[index].keyword)
                                            .then((value) => setState(() {
                                                  posts = value;
                                                }));
                                        ref
                                            .read(searchControllerProvider.notifier)
                                            .searchUser(keywords[index].keyword)
                                            .then((value) => setState(() {
                                                  users = value;
                                                }));
                                      },
                                    ),
                                itemCount: keywords?.length ?? 0)
                            : const Center(child: Text("Hãy tìm kiếm gì đó"));
                      }),
          ),
        ],
      ),
    );
  }
}

class KeywordItem extends ConsumerWidget {
  final Keyword keyword;
  final void Function() onTap;
  const KeywordItem({required this.keyword, super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.search),
      title: Text(keyword.keyword),
      onTap: onTap,
      trailing: IconButton(
          onPressed: () {
            ref.read(searchControllerProvider.notifier).deleteSearch(keyword.id);
          },
          icon: const Icon(Icons.close)),
    );
  }
}
