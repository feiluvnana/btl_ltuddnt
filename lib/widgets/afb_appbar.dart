import 'package:flutter/material.dart';

/// A widget that displays a transparent AppBar with center title.
class AFBAppBar extends AppBar {
  /// Create a transparent AppBar.
  AFBAppBar({super.key, super.title, super.leading, super.actions, super.toolbarHeight})
      : super(automaticallyImplyLeading: false);
}
