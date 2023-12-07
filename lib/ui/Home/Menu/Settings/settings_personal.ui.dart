import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/settings.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPersonalUI extends ConsumerStatefulWidget {
  const SettingsPersonalUI({super.key});

  @override
  ConsumerState<SettingsPersonalUI> createState() => _SettingsPersonalUIState();
}

class _SettingsPersonalUIState extends ConsumerState<SettingsPersonalUI> {
  late final List<dynamic> personalSettingsData = [
    {
      "action": () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SettingsPersonalNameUI()));
      },
      "label": "Tên",
      "description": ref.watch(authenControllerProvider).value?.user?.username ?? "Tên người dùng."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
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
                personalSettingsData.length,
                (index) => AFBChevronRightListTile(
                      title: personalSettingsData[index]["label"],
                      onTap: personalSettingsData[index]["action"],
                      subtitle: personalSettingsData[index]["description"],
                    ))
          ],
        ),
      ),
    );
  }
}

class SettingsPersonalNameUI extends StatelessWidget {
  const SettingsPersonalNameUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
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
            Divider(color: themeData.colorScheme.onPrimary),
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
              child: AFBPrimaryEButton(
                onPressed: () {},
                child: const Center(child: Text("Xác nhận")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AFBSecondaryEButton(
                onPressed: () {},
                child: const Center(child: Text("Hủy")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
