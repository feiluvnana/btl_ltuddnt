import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';

String formatCreatedTime(DateTime date) {
  Duration diff = DateTime.now().difference(date);
  if (diff.inSeconds <= 60) return "Vừa xong";
  if (diff.inHours < 1) return "${diff.inMinutes} phút trước";
  if (diff.inDays < 1) return "${diff.inHours} giờ trước";
  if (diff.inDays < 7) return "${diff.inDays} ngày trước";
  if (diff.inDays < 365) return DateFormat("dd/MM").format(date);
  return "${(diff.inDays ~/ 365)} năm trước";
}

String? getFirstLink(String text) {
  RegExpMatch? match =
      RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+', caseSensitive: false)
          .firstMatch(text);
  return match == null ? null : text.substring(match.start, match.end);
}

TextSpan formatPostDescribed(String described, ThemeData themeData) {
  List<int> indexes = [];
  List<int> links = [];
  List<int> hashtags = [];
  RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+', caseSensitive: false)
      .allMatches(described)
      .forEach((e) {
    indexes.add(e.start);
    indexes.add(e.end);
    links.add(e.start);
  });
  RegExp(r'#[a-z0-9_]+', caseSensitive: false).allMatches(described).forEach((e) {
    indexes.add(e.start);
    indexes.add(e.end);
    hashtags.add(e.start);
  });

  indexes.sort();

  if (indexes.isNotEmpty && indexes[0] != 0) {
    indexes.insert(0, 0);
  }

  List<Map<String, String>> fragments = [];

  for (int i = 0; i < indexes.length - 1; i++) {
    fragments.add({
      described.substring(indexes[i], indexes[i + 1]): links.contains(indexes[i])
          ? "link"
          : hashtags.contains(indexes[i])
              ? "hash"
              : "plain"
    });
  }

  if (indexes.isNotEmpty) {
    fragments.add({described.substring(indexes.last): "plain"});
  } else {
    fragments.add({described: "plain"});
  }

  List<TextSpan> spans = [];

  for (var f in fragments) {
    if (f.values.first == "link") {
      spans.add(TextSpan(
          text: f.keys.first,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              InAppBrowser()
                  .openUrlRequest(urlRequest: URLRequest(url: Uri.tryParse(f.keys.first)));
            },
          style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.lightBlue)));
    } else if (f.values.first == "hash") {
      spans.add(TextSpan(
          text: f.keys.first,
          recognizer: TapGestureRecognizer()..onTap = () {},
          style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor)));
    } else {
      spans.add(TextSpan(text: f.keys.first));
    }
  }

  return TextSpan(children: spans);
}
