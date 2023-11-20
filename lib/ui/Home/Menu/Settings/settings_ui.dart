import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalUI()));
      },
      "label": "Thông tin cá nhân",
      "description": "Cập nhật tên của bạn."
    },
    {
      "icon": Icons.security,
      "action": () {},
      "label": "Bảo mật",
      "description": "Đổi mật khẩu và thực hiện các hoạt động để tăng cường bảo mật tài khoản."
    }
  ];

  final List<dynamic> privacySettingsData = [
    {
      "icon": Icons.no_accounts,
      "action": () {},
      "label": "Chặn",
      "description": "Quản lý các tài khoản bị chặn."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text("Cài đặt", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Cài đặt tài khoản",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text("Quản lý thông tin của bạn và tài khoản nói chung."),
            ...List.generate(accountSettingsData.length,
                (index) => Flexible(child: SettingsItem(data: accountSettingsData[index]))),
            const Divider(thickness: 5),
            Text("Quyền riêng tư",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text("Quản lý quyền riêng tư của bạn."),
            ...List.generate(privacySettingsData.length,
                (index) => Flexible(child: SettingsItem(data: privacySettingsData[index]))),
          ],
        ),
      ),
    ));
  }
}

class PersonalUI extends StatefulWidget {
  const PersonalUI({super.key});

  @override
  State<PersonalUI> createState() => _PersonalUIState();
}

class _PersonalUIState extends State<PersonalUI> {
  late final List<dynamic> accountSettingsData = [
    {
      "action": () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalNameUI()));
      },
      "label": "Tên",
      "description": "Placeholder."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text("Thông tin cá nhân", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Thông tin cá nhân",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ...List.generate(
                accountSettingsData.length,
                (index) => AFBListTile(
                      title: accountSettingsData[index]["label"],
                      onTap: accountSettingsData[index]["action"],
                      subtitle: accountSettingsData[index]["description"],
                    ))
          ],
        ),
      ),
    ));
  }
}

class PersonalNameUI extends StatelessWidget {
  const PersonalNameUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text("Tên", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: themeData.colorScheme.primaryContainer),
            color: themeData.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text("Tên", style: themeData.textTheme.titleMedium),
            ),
            Divider(color: themeData.canvasColor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Họ")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder(), labelText: "Tên đệm")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder(), labelText: "Tên")),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: themeData.colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10)),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Xin lưu ý rằng: ",
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                const TextSpan(
                    text:
                        "Nếu đổi tên trên Anti Fakebook, bạn không thể đổi lại tên trong 60 ngày.")
              ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.canvasColor,
                    backgroundColor: themeData.primaryColor),
                onPressed: () {},
                child: const Center(child: Text("Xác nhận")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Center(child: Text("Hủy")),
              ),
            )
          ],
        ),
      ),
    ));
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
