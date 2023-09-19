import 'package:flutter/material.dart';

/// A widget that displays a transparent AppBar with center title.
class TransparentAppBar extends AppBar {
  /// Create a transparent AppBar.
  TransparentAppBar(
      {super.key, super.title, super.leading, super.actions, super.bottom})
      : super(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.transparent);
}
