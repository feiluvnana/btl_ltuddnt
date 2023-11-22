import 'package:flutter/material.dart';

Future<T?> showAFBModalBottomSheet<T>(
    {required BuildContext context, Widget? header, required List<List<Widget>> blocks}) {
  final themeData = Theme.of(context);
  return showModalBottomSheet<T>(
      backgroundColor: themeData.colorScheme.onInverseSurface,
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null)
              Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: header),
            if (header != null) const SizedBox(height: 8),
            ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: themeData.canvasColor),
                    child: Column(mainAxisSize: MainAxisSize.min, children: blocks[index])),
                itemCount: blocks.length)
          ],
        );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      showDragHandle: true);
}

Future<T?> showAFBDialog<T>(
    {required BuildContext context,
    required Widget title,
    required List<Widget> actions,
    required Widget content}) {
  return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(title: title, content: content, actions: actions));
}
