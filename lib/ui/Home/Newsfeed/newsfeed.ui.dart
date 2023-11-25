import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen.bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed.bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/post_item.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Create&Update/post_create_update_ui.dart';

class NewsfeedUI extends StatefulWidget {
  const NewsfeedUI({super.key});

  @override
  State<NewsfeedUI> createState() => _NewsfeedUIState();
}

class _NewsfeedUIState extends State<NewsfeedUI>
    with AutomaticKeepAliveClientMixin {
  final ctrl = ScrollController();
  var isFetching = false;

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() {
      if (ctrl.offset >= 0.7 * ctrl.position.maxScrollExtent && !isFetching) {
        isFetching = true;
        context
            .read<NewsfeedBloc>()
            .add(NewsfeedGetPosts(finallyCallback: () => isFetching = false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsfeedBloc>().add(const NewsfeedPostRefresh());
      },
      child: BlocBuilder<NewsfeedBloc, NewsfeedState>(
        buildWhen: (previous, current) => previous.posts != current.posts,
        builder: (context, state) {
          return switch (state.posts?.isEmpty) {
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
                controller: ctrl,
                shrinkWrap: true,
                itemBuilder: (context, index) => index == 0
                    ? const CreatePostBar()
                    : PostItem(post: state.posts![index - 1]),
                itemCount: (state.posts?.length ?? 0) + 1),
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

class CreatePostBar extends StatelessWidget {
  const CreatePostBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AuthenBloc, AuthenState>(
            builder: (context, state) {
              return AFBCircleAvatar(imageUrl: state.user?.avatar ?? "");
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PostCreateUpdateUI()));
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
