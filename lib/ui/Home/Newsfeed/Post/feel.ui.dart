import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/helpers/json_converter.dart';
import 'package:Anti_Fakebook/models/feel.model.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeelItem extends StatelessWidget {
  final Feel feel;
  final int postId;

  const FeelItem({super.key, required this.feel, required this.postId});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 10),
          AFBCircleAvatar(imageUrl: feel.author.avatar, radius: 40),
          const SizedBox(width: 10),
          Text(feel.author.name, style: themeData.textTheme.titleMedium),
          const Spacer(),
          Icon(feel.type == FeelType.kudos ? Icons.favorite : Icons.heart_broken,
              color: feel.type == FeelType.kudos
                  ? themeData.colorScheme.primary
                  : themeData.colorScheme.error),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class FeelUI extends ConsumerStatefulWidget {
  final int postId;
  const FeelUI({super.key, required this.postId});

  @override
  ConsumerState<FeelUI> createState() => _FeelUIState();
}

class _FeelUIState extends ConsumerState<FeelUI> {
  List<Feel>? feels;

  @override
  void initState() {
    super.initState();
    ref
        .read(newsfeedControllerProvider.notifier)
        .getListFeels(widget.postId, 0)
        .then((value) => setState(() {
              feels = value?.map((e) => e.$2).toList();
            }));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Feel", style: themeData.textTheme.titleMedium),
        ),
        const Divider(thickness: 5),
        Expanded(
          child: SingleChildScrollView(
            child: ((feels?.length ?? -1) != 0)
                ? Column(
                    children: List.generate(feels?.length ?? 0,
                            (index) => FeelItem(feel: feels![index], postId: widget.postId))
                        .reversed
                        .toList())
                : const Center(child: Text("Chưa có feel nào")),
          ),
        ),
      ],
    );
  }
}
