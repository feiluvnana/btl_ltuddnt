import 'package:Anti_Fakebook/helpers/text_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AFBExpandableText extends StatefulWidget {
  final String text;

  const AFBExpandableText({super.key, required this.text});

  @override
  State<AFBExpandableText> createState() => _AFBExpandableTextState();
}

class _AFBExpandableTextState extends State<AFBExpandableText> {
  bool isExpanded = false;
  Offset popupOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressStart: (details) {
        setState(() => popupOffset = details.globalPosition);
      },
      onLongPress: () => showDialog(
          context: context,
          builder: (context) => Align(
                alignment: Alignment.topLeft,
                child: Transform.translate(
                  offset: popupOffset,
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.text))
                          .whenComplete(() => Navigator.maybePop(context));
                    },
                    child: const Text("Sao chép"),
                  ),
                ),
              )),
      child: LayoutBuilder(builder: (context, size) {
        var tp = TextPainter(
          maxLines: isExpanded ? null : 5,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: formatPostDescribed(widget.text, themeData),
        );
        tp.layout(maxWidth: size.maxWidth);
        var exceeded = tp.didExceedMaxLines;
        if (exceeded) {
          return InkWell(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            child: Text.rich(
              TextSpan(children: [
                formatPostDescribed(widget.text.substring(0, 150), themeData),
                TextSpan(
                    text: "...Xem thêm",
                    style: themeData.textTheme.bodyMedium?.copyWith(
                        color: themeData.colorScheme.inverseSurface, fontWeight: FontWeight.w500))
              ]),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          );
        } else if (isExpanded) {
          return InkWell(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text.rich(
                formatPostDescribed(widget.text, themeData),
                maxLines: 10000000,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Thu gọn",
                style: themeData.textTheme.bodyMedium?.copyWith(
                    color: themeData.colorScheme.inverseSurface, fontWeight: FontWeight.w500),
              )
            ]),
          );
        } else {
          return InkWell(
            onTap: () => setState(() {
              isExpanded = !isExpanded;
            }),
            child: Text.rich(
              formatPostDescribed(widget.text, themeData),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }),
    );
  }
}
