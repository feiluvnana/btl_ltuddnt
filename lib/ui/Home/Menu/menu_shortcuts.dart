import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_selection.dart';
import 'package:flutter/material.dart';

class MenuShortcuts extends StatefulWidget {
  const MenuShortcuts({super.key});

  @override
  State<MenuShortcuts> createState() => _MenuShortcutsState();
}

class _MenuShortcutsState extends State<MenuShortcuts> {
  final List<Map<String, dynamic>> menu = [
    {
      "label": "Hoạt động quảng cáo gần đây",
      "icon": Icons.ads_click,
      "action": () {}
    },
    {"label": "Kỷ niệm", "icon": Icons.history, "action": () {}},
    {"label": "Đã lưu", "icon": Icons.bookmark, "action": () {}},
    {"label": "Video", "icon": Icons.video_camera_back, "action": () {}},
    {"label": "Marketplace", "icon": Icons.store, "action": () {}},
    {"label": "Nhóm", "icon": Icons.group, "action": () {}},
    {"label": "Tìm bạn bè", "icon": Icons.person_search, "action": () {}},
    {"label": "Bảng feed", "icon": Icons.home, "action": () {}},
    {"label": "Avatar", "icon": Icons.not_accessible, "action": () {}},
    {"label": "Chơi game", "icon": Icons.videogame_asset, "action": () {}},
    {"label": "Game giả tưởng", "icon": Icons.videogame_asset, "action": () {}},
    {"label": "Hẹn hò", "icon": Icons.heart_broken, "action": () {}},
    {"label": "Messenger Kids", "icon": Icons.chat_bubble, "action": () {}},
    {"label": "Reels", "icon": Icons.video_camera_back, "action": () {}},
    {"label": "Sự kiện", "icon": Icons.event, "action": () {}},
    {"label": "Trang", "icon": Icons.contact_page, "action": () {}},
    {"label": "Ứng phó khẩn cấp", "icon": Icons.emergency, "action": () {}}
  ];

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Tất cả lối tắt",
            style: themeData.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...List.generate(isCollapsed ? menu.length ~/ 2 : menu.length, (index) {
          return MenuSelection(data: menu[index]);
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
                elevation: const MaterialStatePropertyAll(1),
                surfaceTintColor:
                    const MaterialStatePropertyAll(Colors.black26)),
            onPressed: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(isCollapsed ? "Xem thêm" : "Ẩn bớt")]),
          ),
        )
      ],
    );
  }
}
