import 'package:Anti_Fakebook/controllers/authen.controller.dart';
import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/ui/Home/Menu/Settings/settings.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Profile/profile.ui.dart';
import 'package:Anti_Fakebook/ui/Home/home.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuUI extends StatelessWidget {
  const MenuUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          MenuHeader(),
          MenuProfile(),
          Divider(indent: 10, endIndent: 10),
          MenuShortcuts(),
          Divider(indent: 10, endIndent: 10),
          MenuHelpCenter(),
          Divider(indent: 10, endIndent: 10),
          MenuSettings(),
          MenuLogoutButton()
        ],
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 10),
        Text("Menu",
            style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsUI()));
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: themeData.colorScheme.onInverseSurface, shape: BoxShape.circle),
            child: const Icon(Icons.settings),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: themeData.colorScheme.onInverseSurface, shape: BoxShape.circle),
            child: const Icon(Icons.search),
          ),
        )
      ],
    );
  }
}

class MenuHelpCenter extends StatefulWidget {
  const MenuHelpCenter({super.key});

  @override
  State<MenuHelpCenter> createState() => _MenuHelpCenterState();
}

class _MenuHelpCenterState extends State<MenuHelpCenter> {
  final List<Map<String, dynamic>> menu = [
    {"label": "Trung tâm trợ giúp", "icon": Icons.help_center, "action": () {}},
    {"label": "Hộp thư hỗ trợ", "icon": Icons.markunread_mailbox_outlined, "action": () {}},
    {"label": "Báo cáo sự cố", "icon": Icons.feedback, "action": () {}},
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
          child: Container(
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.help),
                const SizedBox(width: 10),
                Text(
                  "Trợ giúp & hỗ trợ",
                  style: themeData.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
        ),
        ...List.generate(isCollapsed ? 0 : menu.length, (index) {
          return AFBMenuEButton(data: menu[index]);
        }),
      ],
    );
  }
}

class MenuProfile extends ConsumerWidget {
  const MenuProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileUI()));
      },
      child: Row(
        children: [
          const SizedBox(width: 10),
          AFBCircleAvatar(
              imageUrl: ref
                      .watch(profileControllerProvider.select((value) => value.value?.profile))
                      ?.avatar ??
                  ""),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              ref.watch(profileControllerProvider).value?.profile?.username ?? "",
              style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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

class MenuLogoutButton extends ConsumerWidget {
  const MenuLogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: AFBDangerEButton(
        onPressed: () {
          ref
            ..read(authenControllerProvider.notifier).logout()
            ..read(newsfeedControllerProvider.notifier).reset()
            ..read(friendControllerProvider.notifier).reset();
          Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          ref.read(authenControllerProvider.notifier).updateSignupInfo(info: {});
        },
        child:
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Đăng xuất")]),
      ),
    );
  }
}

class MenuShortcuts extends StatefulWidget {
  const MenuShortcuts({super.key});

  @override
  State<MenuShortcuts> createState() => _MenuShortcutsState();
}

class _MenuShortcutsState extends State<MenuShortcuts> {
  final List<Map<String, dynamic>> menu = [
    // {"label": "Hoạt động quảng cáo gần đây", "icon": Icons.ads_click, "action": () {}},
    // {"label": "Kỷ niệm", "icon": Icons.history, "action": () {}},
    // {"label": "Đã lưu", "icon": Icons.bookmark, "action": () {}},
    {
      "label": "Video",
      "icon": Icons.video_camera_back,
      "action": () {
        HomeUIState.tabController.index = 2;
      }
    },
    // {"label": "Marketplace", "icon": Icons.store, "action": () {}},
    // {"label": "Nhóm", "icon": Icons.group, "action": () {}},
    {
      "label": "Tìm bạn bè",
      "icon": Icons.person_search,
      "action": () {
        HomeUIState.tabController.index = 1;
      }
    },
    {
      "label": "Bảng feed",
      "icon": Icons.home,
      "action": () {
        HomeUIState.tabController.index = 0;
      }
    },
    // {"label": "Avatar", "icon": Icons.not_accessible, "action": () {}},
    // {"label": "Chơi game", "icon": Icons.videogame_asset, "action": () {}},
    // {"label": "Game giả tưởng", "icon": Icons.videogame_asset, "action": () {}},
    // {"label": "Hẹn hò", "icon": Icons.heart_broken, "action": () {}},
    // {"label": "Messenger Kids", "icon": Icons.chat_bubble, "action": () {}},
    // {"label": "Reels", "icon": Icons.video_camera_back, "action": () {}},
    // {"label": "Sự kiện", "icon": Icons.event, "action": () {}},
    // {"label": "Trang", "icon": Icons.contact_page, "action": () {}},
    // {"label": "Ứng phó khẩn cấp", "icon": Icons.emergency, "action": () {}}
  ];

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Tất cả lối tắt",
                  style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            ...List.generate(isCollapsed ? menu.length ~/ 2 : menu.length, (index) {
              return AFBMenuEButton(data: menu[index]);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: AFBSecondaryEButton(
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
      },
    );
  }
}

class MenuSettings extends StatefulWidget {
  const MenuSettings({super.key});

  @override
  State<MenuSettings> createState() => _MenuSettingsState();
}

class _MenuSettingsState extends State<MenuSettings> {
  late final List<Map<String, dynamic>> menu = [
    {
      "label": "Cài đặt",
      "icon": Icons.settings,
      "action": () {
        Navigator.pushNamed(context, "/settings");
      }
    }
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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.settings),
                const SizedBox(width: 10),
                Text("Cài đặt & Quyền riêng tư",
                    style: themeData.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                AnimatedRotation(
                    turns: isCollapsed ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_up)),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        ...List.generate(isCollapsed ? 0 : menu.length, (index) {
          return AFBMenuEButton(data: menu[index]);
        }),
      ],
    );
  }
}
