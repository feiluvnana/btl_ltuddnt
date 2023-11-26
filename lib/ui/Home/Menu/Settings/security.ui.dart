import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityUI extends StatefulWidget {
  const SecurityUI({super.key});

  @override
  State<SecurityUI> createState() => _SecurityUIState();
}

class _SecurityUIState extends State<SecurityUI> {
  late final List<dynamic> securitySettingsData = [
    {
      "icon": const Icon(Icons.key, size: 36),
      "action": () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SecurityChangePassUI()));
      },
      "label": "Đổi mật khẩu",
      "description": "Bạn nên sử dụng mật khẩu mạnh mà bạn chưa dùng ở đâu khác."
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBTransparentAppBar(
        title: Text("Bảo mật", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Đăng nhập",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ...List.generate(
                securitySettingsData.length,
                (index) => AFBChevronRightListTile(
                      leading: securitySettingsData[index]["icon"],
                      title: securitySettingsData[index]["label"],
                      onTap: securitySettingsData[index]["action"],
                      subtitle: securitySettingsData[index]["description"],
                    ))
          ],
        ),
      ),
    );
  }
}

class SecurityChangePassUI extends ConsumerStatefulWidget {
  const SecurityChangePassUI({super.key});

  @override
  ConsumerState<SecurityChangePassUI> createState() => _SecurityChangePassUIState();
}

class _SecurityChangePassUIState extends ConsumerState<SecurityChangePassUI> {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final newPassword = TextEditingController();
  final newPassword2 = TextEditingController();
  var obscureText = true;
  var isLocked = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBTransparentAppBar(
        title: Text("Đổi mật khẩu", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: themeData.colorScheme.primaryContainer),
            color: themeData.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: password,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Mật khẩu cũ")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: newPassword,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Mật khẩu mới")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: newPassword2,
                    validator: (value) =>
                        value != newPassword.text ? "Nhập lại mật khẩu mới không khớp." : null,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nhập lại mật khẩu mới")),
              ),
              Row(
                children: [
                  Checkbox(
                      value: !obscureText,
                      onChanged: (value) => setState(() {
                            obscureText = !obscureText;
                          })),
                  Text("Hiện mật khẩu", style: themeData.textTheme.titleMedium)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AFBPrimaryEButton(
                  onPressed: isLocked
                      ? null
                      : () async {
                          if (formKey.currentState?.validate() != true) return;
                          setState(() => isLocked = true);
                          await ref.read(authenControllerProvider.notifier).changePassword(
                              password: password.text,
                              newPassword: newPassword.text,
                              onSuccess: () {
                                Navigator.maybePop(context);
                              });
                          () => setState(() => isLocked = false);
                        },
                  child: const Center(child: Text("Xác nhận")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AFBSecondaryEButton(
                  onPressed: () {},
                  child: const Center(child: Text("Hủy")),
                ),
              ),
              TextButton(onPressed: () {}, child: const Center(child: Text("Quên mật khẩu?")))
            ],
          ),
        ),
      ),
    );
  }
}
