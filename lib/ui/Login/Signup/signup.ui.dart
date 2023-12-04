import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/email_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupUI extends ConsumerWidget {
  const SignupUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) =>
          Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
      child: Scaffold(
        appBar: AFBTransparentAppBar(
          title: Text(
            "Tạo tài khoản",
            style: themeData.textTheme.titleMedium,
          ),
          leading: IconButton(
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Tham gia Anti Fakebook",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const FlutterLogo(size: 100),
              const Text(
                  "Tạo tài khoản để kết nối với bạn bè, người thân và cộng đồng có chung sở thích."),
              AFBPrimaryEButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EmailSignupUI()));
                  },
                  child: const Text("Bắt đầu")),
              AFBSecondaryEButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                    ref.read(authenControllerProvider.notifier).updateSignupInfo(info: {});
                  },
                  child: const Text("Tôi có tài khoản rồi")),
            ],
          ),
        ),
      ),
    );
  }
}
