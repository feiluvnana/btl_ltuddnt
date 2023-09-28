import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_selection.dart';
import 'package:flutter/material.dart';

class MenuHelpCenter extends StatefulWidget {
  const MenuHelpCenter({super.key});

  @override
  State<MenuHelpCenter> createState() => _MenuHelpCenterState();
}

class _MenuHelpCenterState extends State<MenuHelpCenter> {
  final List<Map<String, dynamic>> menu = [
    {"label": "Trung tâm trợ giúp", "icon": Icons.help_center, "action": () {}},
    {
      "label": "Hộp thư hỗ trợ",
      "icon": Icons.markunread_mailbox_outlined,
      "action": () {}
    },
    {"label": "Báo cáo sự cố", "icon": Icons.report, "action": () {}},
    {"label": "An toàn", "icon": Icons.safety_check, "action": () {}},
    {"label": "Điều khoản & chính sách", "icon": Icons.policy, "action": () {}},
  ];

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isCollapsed = !isCollapsed;
            });
          },
          child: Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.help),
              const SizedBox(width: 10),
              Text(
                "Trợ giúp & hỗ trợ",
                style: themeData.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              AnimatedRotation(
                  turns: isCollapsed ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_up)),
              const SizedBox(width: 10),
            ],
          ),
        ),
        ...List.generate(isCollapsed ? 0 : menu.length, (index) {
          return MenuSelection(data: menu[index]);
        }),
      ],
    );
  }
}
