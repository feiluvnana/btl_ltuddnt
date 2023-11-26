import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/text_formater.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/mark.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/services/apis/api.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart';

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
                    children: [Text(mark.poster.name), Text(mark.markContent)]),
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

class MarkUI extends StatefulWidget {
  const MarkUI({super.key});

  @override
  State<MarkUI> createState() => _MarkUIState();
}

class _MarkUIState extends State<MarkUI> {
  List<Mark>? marks;

  @override
  void initState() {
    super.initState();
    Api().getMarkComment(1, 0, 10).then((value) {
      setState(() =>
          marks = ((value?["data"] ?? []) as List).map<Mark>((e) => Mark.fromJson(e)).toList());
    });
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
        const Divider(),
        Column(
          children: List.generate(marks?.length ?? 0, (index) => MarkItem(mark: marks![index])),
        )
      ],
    );
  }
}
