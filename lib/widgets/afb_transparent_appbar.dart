import 'package:flutter/material.dart';

/// A widget that displays a transparent AppBar with center title.
class AFBTransparentAppBar extends AppBar {
  /// Create a transparent AppBar.
  AFBTransparentAppBar({super.key, super.title, super.leading, super.actions, super.toolbarHeight})
      : super(automaticallyImplyLeading: false, backgroundColor: Colors.white);
}
