import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          "Menu",
          style: themeData.textTheme.headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.black26, shape: BoxShape.circle),
            child: const Icon(Icons.settings),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.black26, shape: BoxShape.circle),
            child: const Icon(Icons.search),
          ),
        )
      ],
    );
  }
}
