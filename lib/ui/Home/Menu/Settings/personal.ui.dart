import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class PersonalUI extends StatefulWidget {
  const PersonalUI({super.key});

  @override
  State<PersonalUI> createState() => _PersonalUIState();
}

class _PersonalUIState extends State<PersonalUI> {
  late final List<dynamic> personalSettingsData = [
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
    return Scaffold(
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

class PersonalNameUI extends StatelessWidget {
  const PersonalNameUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
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
