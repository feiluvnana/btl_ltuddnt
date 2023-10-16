import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newfeeds_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/data.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/create_status_top_bar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/post_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsfeedUI extends StatelessWidget {
  const NewsfeedUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewfeedsBloc(),
      child: SingleChildScrollView(
        child: BlocBuilder<NewfeedsBloc, NewfeedsState>(
          builder: (context, state) {
            return Column(
              children: [
                const CreateStatusTopBar(),
                const Divider(thickness: 5),
                ...List.generate(state.posts.length,
                    (index) => PostUI(post: state.posts[index])),
                const Divider(thickness: 5)
              ],
            );
          },
        ),
      ),
    );
  }
}
