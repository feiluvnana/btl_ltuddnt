import 'package:flutter/material.dart';

class AFBListTile extends StatelessWidget {
  const AFBListTile({super.key, this.label, required this.onTap, this.subtitle, this.title});

  final void Function() onTap;
  final String? label;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Text(label ?? "", style: themeData.textTheme.titleMedium),
      trailing: const Icon(Icons.chevron_right, size: 36),
      title: Text(title ?? ""),
      subtitle: Text(subtitle ?? ""),
      contentPadding: EdgeInsets.zero,
    );
  }
}
