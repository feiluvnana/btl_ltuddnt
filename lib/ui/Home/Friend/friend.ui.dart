import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Friend/friend_suggested.ui.dart';
import 'package:flutter/material.dart';

class FriendUI extends StatelessWidget {
  const FriendUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FriendHeader(),
        Wrap(spacing: 8, children: [
          const SizedBox(width: 2),
          ChoiceChip(
              selected: false,
              onSelected: (_) => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const FriendSuggestedUI())),
              label: const Text("Gợi ý")),
          ChoiceChip(selected: false, onSelected: (_) {}, label: const Text("Tất cả bạn bè"))
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("Lời mời kết bạn",
              style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class FriendHeader extends StatelessWidget {
  const FriendHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 10),
        Text("Bạn bè",
            style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
            child: const Icon(Icons.search),
          ),
        )
      ],
    );
  }
}
