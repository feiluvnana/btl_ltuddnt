import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/CreatePost/createpost_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/skeleton_wrapper.dart';
import 'package:flutter/material.dart';

class CreateStatusTopBar extends StatefulWidget {
  const CreateStatusTopBar({super.key});

  @override
  State<CreateStatusTopBar> createState() => _CreateStatusTopBarState();
}

class _CreateStatusTopBarState extends State<CreateStatusTopBar> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonWrapper(
            enabled: isLoading,
            child: const CircleUserAvatar(),
          ),
        ),
        Expanded(
            child: SkeletonWrapper(
          enabled: isLoading,
          child: const _WhatAreYouThinkingContainer(),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SkeletonWrapper(
              enabled: isLoading, child: const _AddMediaToStatusButton()),
        )
      ],
    );
  }
}

class _AddMediaToStatusButton extends StatelessWidget {
  const _AddMediaToStatusButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreatePostUI()));
        },
        child: const Icon(Icons.image));
  }
}

class _WhatAreYouThinkingContainer extends StatelessWidget {
  const _WhatAreYouThinkingContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all()),
      child: const Text("Bạn đang nghĩ gì?"),
    );
  }
}
