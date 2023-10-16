import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/post_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CreatePost/createpost_ui.dart';

class NewsfeedUI extends StatelessWidget {
  const NewsfeedUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsfeedBloc(),
      child: SingleChildScrollView(
        child: BlocBuilder<NewsfeedBloc, NewsfeedState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleUserAvatar(),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all()),
                        child: const Text("Bạn đang nghĩ gì?"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePostUI()));
                          },
                          child: const Icon(Icons.image)),
                    )
                  ],
                ),
                ...List.generate(state.posts.length,
                    (index) => PostUI(post: state.posts[index])),
              ],
            );
          },
        ),
      ),
    );
  }
}
