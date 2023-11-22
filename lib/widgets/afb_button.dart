import 'package:flutter/material.dart';

class AFBDangerEButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const AFBDangerEButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: themeData.canvasColor, backgroundColor: themeData.colorScheme.error),
        onPressed: onPressed,
        child: child);
  }
}

class AFBPrimaryEButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AFBPrimaryEButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: themeData.canvasColor, backgroundColor: themeData.primaryColor),
        onPressed: onPressed,
        child: child);
  }
}

class AFBSecondaryEButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const AFBSecondaryEButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}