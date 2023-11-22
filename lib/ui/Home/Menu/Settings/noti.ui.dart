import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class NotiUI extends StatefulWidget {
  const NotiUI({super.key});

  @override
  State<NotiUI> createState() => _NotiUIState();
}

class _NotiUIState extends State<NotiUI> {
  late final List<dynamic> notiTypeSettingsData = [
    {
      "icon": const Icon(Icons.favorite, size: 36),
      "action": () {},
      "label": "Bình luận/Thích",
      "description": "Bình luận/thích bài viết của bạn hoặc bài mà bạn thích/bình luận."
    },
    {
      "icon": const Icon(Icons.supervisor_account, size: 36),
      "action": () {},
      "label": "Cập nhật từ bạn bè",
      "description": "Bài mới, video mới, hành động thích, bình luận."
    },
    {
      "icon": const Icon(Icons.person_add, size: 36),
      "action": () {},
      "label": "Lời mời kết bạn",
      "description": "Lời mời kết bạn từ mọi người."
    },
    {
      "icon": const Icon(Icons.account_box, size: 36),
      "action": () {},
      "label": "Những người bạn có thể biết",
      "description": "Thông báo về người bạn có thể quen."
    },
    {
      "icon": const Icon(Icons.cake, size: 36),
      "action": () {},
      "label": "Sinh nhật",
      "description": "Sinh nhật của bạn hay bạn bè."
    },
    {
      "icon": const Icon(Icons.video_camera_back, size: 36),
      "action": () {},
      "label": "Video của bạn được duyệt",
      "description": "Thông báo về video đã được duyệt."
    },
    {
      "icon": const Icon(Icons.report, size: 36),
      "action": () {},
      "label": "Phản hồi về báo cáo bài viết",
      "description": "Thông báo về các phản hồi về báo cáo."
    },
  ];

  late final List<dynamic> notiMethodSettingsData = [
    {
      "icon": const Icon(Icons.notifications_active, size: 36),
      "action": () {},
      "label": "Thông báo đẩy",
      "description": "Placeholder."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text("Cài đặt thông báo", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Bạn nhận thông báo về",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              ...List.generate(
                  notiTypeSettingsData.length,
                  (index) => AFBChevronRightListTile(
                        leading: notiTypeSettingsData[index]["icon"],
                        title: notiTypeSettingsData[index]["label"],
                        onTap: notiTypeSettingsData[index]["action"],
                        subtitle: notiTypeSettingsData[index]["description"],
                      )),
              Text("Bạn nhận thông báo qua",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              ...List.generate(
                  notiMethodSettingsData.length,
                  (index) => AFBChevronRightListTile(
                        leading: notiMethodSettingsData[index]["icon"],
                        title: notiMethodSettingsData[index]["label"],
                        onTap: notiMethodSettingsData[index]["action"],
                        subtitle: notiMethodSettingsData[index]["description"],
                      ))
            ],
          ),
        ),
      ),
    ));
  }
}
