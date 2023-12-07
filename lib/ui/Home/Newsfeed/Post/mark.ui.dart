import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/json_converter.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/mark.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkItem extends StatelessWidget {
  final Mark mark;

  const MarkItem({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        AFBCircleAvatar(imageUrl: mark.poster.avatar, radius: 40),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: mark.typeOfMark == MarkType.trust
                  ? themeData.colorScheme.primaryContainer
                  : themeData.colorScheme.errorContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mark.poster.name, style: themeData.textTheme.titleMedium),
                      Text(mark.markContent)
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(formatCreatedTime(mark.created)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Column(
                children: List.generate(
                    mark.comments.length,
                    (index) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              color: themeData.colorScheme.tertiaryContainer,
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Text(mark.comments[index].poster.name),
                                  Text(mark.comments[index].content)
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(formatCreatedTime(mark.comments[index].created)),
                            ),
                          ],
                        )),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class MarkUI extends ConsumerStatefulWidget {
  final int postId;
  const MarkUI({super.key, required this.postId});

  @override
  ConsumerState<MarkUI> createState() => _MarkUIState();
}

class _MarkUIState extends ConsumerState<MarkUI> {
  List<Mark>? marks;

  @override
  void initState() {
    super.initState();
    ref
        .read(newsfeedControllerProvider.notifier)
        .getMarkComment(widget.postId, 0)
        .then((value) => setState(() {
              marks = value;
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
          child: Text("Mark", style: themeData.textTheme.titleMedium),
        ),
        const Divider(thickness: 5),
        Expanded(
          child: SingleChildScrollView(
            child: ((marks?.length ?? -1) != 0)
                ? Column(
                    children:
                        List.generate(marks?.length ?? 0, (index) => MarkItem(mark: marks![index])))
                : const Center(child: Text("Chưa có bình luận nào")),
          ),
        ),
      ],
    );
  }
}