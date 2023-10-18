import 'package:flutter/services.dart';

class Emoji {
  static final Map<String, String> data = {
    ":-)": "\u{1f642}",
    ":)": "\u{1f642}",
    ":]": "\u{1f642}",
    "=)": "\u{1f604}",
    "^_^": "\u{1f604}",
    ":-(": "\u{1f61e}",
    ":(": "\u{1f61e}",
    ":[": "\u{1f61e}",
    "=(": "\u{1f61e}",
    ":-P": "\u{1f61b}",
    ":P": "\u{1f61b}",
    "=P": "\u{1f61b}",
    ":-D": "\u{1f600}",
    ":D": "\u{1f600}",
    '=D': "\u{1f600}",
    ':-O': "\u{1f62e}",
    ":O": "\u{1f62e}",
    ":o": "\u{1f62e}",
    ":-o": "\u{1f62e}",
    ";-)": "\u{1f609}",
    ';)': "\u{1f609}",
    "8-)": "\u{1f60e}",
    "8)": "\u{1f60e}",
    "B-)": "\u{1f60e}",
    "B)": "\u{1f60e}",
    ">:(": "\u{1f620}",
    ">:-(": "\u{1f620}",
    '>:O': "\u{1f620}",
    ">:-O": "\u{1f620}",
    ":/": "\u{1f615}",
    ":-/": "\u{1f615}",
    r":\": "\u{1f615}",
    r":-\": "\u{1f615}",
    ":'(": "\u{1f622}",
    "=3:)": "\u{1f608}",
    "3:-)": "\u{1f608}",
    "=O:)": "\u{1f607}",
    "O:-)": "\u{1f607}",
    "=:-*": "\u{1f617}",
    ":*": "\u{1f617}",
    "<3": "\u2764",
    "-_-": "\u{1f611}",
    "<(“)": "\u{1f427}",
  };

  static String parse(String str) {
    str = " $str ";
    for (var s in data.keys) {
      str = str.replaceAll(" $s ", " ${data[s]} ");
    }
    return str.substring(1, str.length - 1);
  }
}

class EmojiInputFormatter extends TextInputFormatter {
  const EmojiInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: Emoji.parse(newValue.text));
  }
}
