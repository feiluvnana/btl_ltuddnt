import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_selection.dart';
import 'package:flutter/material.dart';

class MenuSettings extends StatefulWidget {
  const MenuSettings({super.key});

  @override
  State<MenuSettings> createState() => _MenuSettingsState();
}

class _MenuSettingsState extends State<MenuSettings> {
  final List<Map<String, dynamic>> menu = [
    {"label": "Cài đặt", "icon": Icons.settings, "action": () {}},
    {"label": "Yêu cầu từ thiết bị", "icon": Icons.smartphone, "action": () {}},
    {
      "label": "Hoạt động quảng cáo gần đây",
      "icon": Icons.ads_click,
      "action": () {}
    },
    {
      "label": "Đơn đặt hàng và thanh toán",
      "icon": Icons.credit_card,
      "action": () {}
    },
    {"label": "Lịch sử liên kết", "icon": Icons.link, "action": () {}},
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
              const Icon(Icons.settings),
              const SizedBox(width: 10),
              Text(
                "Cài đặt & quyền riêng tư",
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
