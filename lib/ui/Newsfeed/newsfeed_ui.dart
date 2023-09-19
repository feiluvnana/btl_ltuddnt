import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Newsfeed/create_status_top_bar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Newsfeed/post.dart';
import 'package:flutter/material.dart';

class NewsfeedUI extends StatelessWidget {
  const NewsfeedUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CreateStatusTopBar(),
        Divider(thickness: 5),
        Post(),
        Divider(thickness: 5)
      ],
    );
  }
}
