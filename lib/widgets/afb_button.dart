import 'package:flutter/material.dart';

class AFBDangerEButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AFBDangerEButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            splashFactory: InkRipple.splashFactory,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            foregroundColor: themeData.colorScheme.onPrimary,
            backgroundColor: themeData.colorScheme.error),
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
          elevation: 0,
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          foregroundColor: themeData.colorScheme.onPrimary,
          backgroundColor: themeData.colorScheme.primary,
        ),
        onPressed: onPressed,
        child: child);
  }
}

class AFBSecondaryEButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AFBSecondaryEButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          foregroundColor: themeData.colorScheme.onBackground,
          backgroundColor: themeData.colorScheme.onInverseSurface),
      child: child,
    );
  }
}
