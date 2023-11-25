import 'package:flutter/material.dart';

class AFBChevronRightListTile extends StatelessWidget {
  const AFBChevronRightListTile(
      {super.key, this.leading, required this.onTap, this.subtitle, this.title});

  final void Function() onTap;
  final Widget? leading;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: leading,
      trailing: const Icon(Icons.chevron_right, size: 36),
      title: title == null ? null : Text(title!, style: themeData.textTheme.titleMedium),
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: EdgeInsets.zero,
    );
  }
}

class AFBBottomSheetListTile extends StatelessWidget {
  const AFBBottomSheetListTile(
      {super.key, required this.onTap, this.leading, this.title, this.subtitle, this.color});

  final void Function() onTap;
  final IconData? leading;
  final String? title;
  final String? subtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(leading, size: 30),
      title: title == null ? null : Text(title!, style: themeData.textTheme.titleMedium),
      textColor: color,
      iconColor: color,
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      dense: true,
    );
  }
}

class AFBMenuOptionListTile extends StatelessWidget {
  const AFBMenuOptionListTile({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          tileColor: themeData.colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          dense: true,
          leading: Icon(data["icon"]),
          title: Text(data["label"]),
          onTap: data["action"],
        ),
      ),
    );
  }
}
