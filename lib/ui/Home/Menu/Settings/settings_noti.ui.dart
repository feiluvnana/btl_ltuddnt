import 'package:Anti_Fakebook/controllers/settings.controller.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotiUI extends ConsumerStatefulWidget {
  const SettingsNotiUI({super.key});

  @override
  ConsumerState<SettingsNotiUI> createState() => _NotiUIState();
}

class _NotiUIState extends ConsumerState<SettingsNotiUI> {
  late final List<dynamic> notiTypeSettingsData = [
    {
      "icon": const Icon(Icons.favorite, size: 36),
      "label": "Bình luận/Thích",
      "description": "Bình luận/thích bài viết của bạn hoặc bài mà bạn thích/bình luận."
    },
    {
      "icon": const Icon(Icons.supervisor_account, size: 36),
      "label": "Cập nhật từ bạn bè",
      "description": "Bài mới, video mới, hành động thích, bình luận."
    },
    {
      "icon": const Icon(Icons.person_add, size: 36),
      "label": "Lời mời kết bạn",
      "description": "Lời mời kết bạn từ mọi người."
    },
    {
      "icon": const Icon(Icons.account_box, size: 36),
      "label": "Những người bạn có thể biết",
      "description": "Thông báo về người bạn có thể quen."
    },
    {
      "icon": const Icon(Icons.cake, size: 36),
      "label": "Sinh nhật",
      "description": "Sinh nhật của bạn hay bạn bè."
    },
    {
      "icon": const Icon(Icons.video_camera_back, size: 36),
      "label": "Video của bạn được duyệt",
      "description": "Thông báo về video đã được duyệt."
    },
    {
      "icon": const Icon(Icons.feedback, size: 36),
      "label": "Phản hồi về báo cáo bài viết",
      "description": "Thông báo về các phản hồi về báo cáo."
    },
  ];

  late final List<dynamic> notiMethodSettingsData = [
    {
      "icon": const Icon(Icons.notifications_active, size: 36),
      "action": () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SettingsNotiMethodUI()));
      },
      "label": "Thông báo đẩy",
      "description": "Cài đặt thông báo đẩy."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        title: Text("Cài đặt thông báo", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            var types = ref.watch(
                settingsControllerProvider.select((value) => value.value?.notiSettings?.types));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Bạn nhận thông báo về",
                    style:
                        themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ...List.generate(
                    types?.length ?? 0,
                    (index) => AFBSwitchRightListTile(
                          enabled: types![index],
                          leading: notiTypeSettingsData[index]["icon"],
                          title: notiTypeSettingsData[index]["label"],
                          onChanged: (value) => ref
                              .read(settingsControllerProvider.notifier)
                              .setPushSettings(ref
                                  .read(settingsControllerProvider)
                                  .value!
                                  .notiSettings!
                                  .toggleTypes(index)),
                          subtitle: notiTypeSettingsData[index]["description"],
                        )),
                Text("Bạn nhận thông báo qua",
                    style:
                        themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ...List.generate(
                    notiMethodSettingsData.length,
                    (index) => AFBChevronRightListTile(
                          leading: notiMethodSettingsData[index]["icon"],
                          title: notiMethodSettingsData[index]["label"],
                          onTap: notiMethodSettingsData[index]["action"],
                          subtitle: notiMethodSettingsData[index]["description"],
                        ))
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SettingsNotiMethodUI extends ConsumerStatefulWidget {
  const SettingsNotiMethodUI({
    super.key,
  });

  @override
  ConsumerState<SettingsNotiMethodUI> createState() => _NotiSettingsMethodUIState();
}

class _NotiSettingsMethodUIState extends ConsumerState<SettingsNotiMethodUI> {
  late final List<dynamic> notiMethodSettingsData = [
    {
      "icon": const Icon(Icons.volume_up, size: 36),
      "label": "Âm nói",
      "description": "Phát âm nói khi có thông báo tới."
    },
    {
      "icon": const Icon(Icons.notifications, size: 36),
      "label": "Thông báo đẩy",
      "description": "Tắt hoặc bật thông báo đẩy."
    },
    {
      "icon": const Icon(Icons.vibration, size: 36),
      "label": "Rung",
      "description": "Rung khi có thông báo tới."
    },
    {
      "icon": const Icon(Icons.flash_on, size: 36),
      "label": "Đèn LED",
      "description": "Nháy đèn LED khi có thông báo tới."
    }
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        title: Text("Thông báo đẩy", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            var methods = ref.watch(
                settingsControllerProvider.select((value) => value.value?.notiSettings?.methods));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  methods?.length ?? 0,
                  (index) => AFBSwitchRightListTile(
                        enabled: methods![index],
                        leading: notiMethodSettingsData[index]["icon"],
                        title: notiMethodSettingsData[index]["label"],
                        onChanged: (value) => ref
                            .read(settingsControllerProvider.notifier)
                            .setPushSettings(ref
                                .read(settingsControllerProvider)
                                .value!
                                .notiSettings!
                                .toggleMethod(index)),
                        subtitle: notiMethodSettingsData[index]["description"],
                      )),
            );
          }),
        ),
      ),
    );
  }
}
