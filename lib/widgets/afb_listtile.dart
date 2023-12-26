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
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: ListTile(
        leading: leading,
        trailing: const Icon(Icons.chevron_right, size: 36),
        title: title == null ? null : Text(title!, style: themeData.textTheme.titleMedium),
        subtitle: subtitle == null ? null : Text(subtitle!),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class AFBSwitchRightListTile extends StatelessWidget {
  const AFBSwitchRightListTile(
      {super.key,
      this.leading,
      this.subtitle,
      this.title,
      required this.enabled,
      required this.onChanged});

  final bool enabled;
  final void Function(bool) onChanged;
  final Widget? leading;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      leading: leading,
      trailing: Switch(value: enabled, onChanged: onChanged),
      title: title == null ? null : Text(title!, style: themeData.textTheme.titleMedium),
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: EdgeInsets.zero,
    );
  }
}

class AFBBottomSheetListTile extends StatelessWidget {
  const AFBBottomSheetListTile(
      {super.key, required this.onTap, this.leading, this.title, this.subtitle, this.color});

  final void Function()? onTap;
  final IconData? leading;
  final String? title;
  final String? subtitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: ListTile(
        leading: Icon(leading, size: 30),
        title: title == null
            ? null
            : Text(title!, style: themeData.textTheme.titleMedium?.copyWith(color: color)),
        textColor: color,
        iconColor: color,
        subtitle: subtitle == null ? null : Text(subtitle!),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        dense: true,
      ),
    );
  }
}

class AFBMenuEButton extends StatelessWidget {
  const AFBMenuEButton({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: InkWell(
        onTap: data["action"],
        splashFactory: InkRipple.splashFactory,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          tileColor: themeData.colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          dense: true,
          titleTextStyle: themeData.textTheme.titleMedium,
          leading: Icon(data["icon"]),
          title: Text(data["label"]),
        ),
      ),
    );
  }
}
