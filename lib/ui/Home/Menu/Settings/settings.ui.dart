import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/Settings/settings_block.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/Settings/settings_noti.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/Settings/settings_personal.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/Settings/settings_security.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  late final List<dynamic> accountSettingsData = [
    {
      "icon": Icons.manage_accounts,
      "action": () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SettingsPersonalUI()));
      },
      "label": "Thông tin cá nhân",
      "description": "Cập nhật tên của bạn."
    },
    {
      "icon": Icons.security,
      "action": () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SettingsSecurityUI()));
      },
      "label": "Bảo mật",
      "description": "Đổi mật khẩu và thực hiện các hoạt động để tăng cường bảo mật tài khoản."
    }
  ];

  late final List<dynamic> privacySettingsData = [
    {
      "icon": Icons.no_accounts,
      "action": () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsBlockUI()));
      },
      "label": "Chặn",
      "description": "Quản lý các tài khoản bị chặn."
    }
  ];

  late final List<dynamic> notiSettingsData = [
    {
      "icon": Icons.edit_notifications,
      "action": () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsNotiUI()));
      },
      "label": "Cài đặt thông báo",
      "description": "Cho phép cài đặt việc nhận các thông báo của ứng dụng."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBTransparentAppBar(
        title: Text("Cài đặt", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Cài đặt tài khoản",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Text("Quản lý thông tin của bạn và tài khoản nói chung."),
              ...List.generate(accountSettingsData.length,
                  (index) => SettingsItem(data: accountSettingsData[index])),
              const Divider(thickness: 5),
              Text("Quyền riêng tư",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Text("Quản lý quyền riêng tư của bạn."),
              ...List.generate(privacySettingsData.length,
                  (index) => SettingsItem(data: privacySettingsData[index])),
              const Divider(thickness: 5),
              Text("Cài đặt thông báo",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Text("Quản lý các loại thông báo bạn có thể nhận."),
              ...List.generate(
                  notiSettingsData.length, (index) => SettingsItem(data: notiSettingsData[index])),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: InkWell(
        onTap: data["action"],
        child: Row(
          children: [
            Icon(data["icon"], size: 36),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["label"], style: themeData.textTheme.titleMedium),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width - 106,
                    child: Text(data["description"], maxLines: 2))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
