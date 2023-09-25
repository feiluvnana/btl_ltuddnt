import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          const SizedBox(width: 10),
          const CircleUserAvatar(),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Username",
              style: themeData.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Xem trang cá nhân của bạn",
              style: themeData.textTheme.bodySmall,
            )
          ])
        ],
      ),
    );
  }
}
