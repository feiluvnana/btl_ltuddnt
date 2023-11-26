import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/verify_code.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordUI extends ConsumerStatefulWidget {
  const ForgetPasswordUI({super.key});

  @override
  ConsumerState<ForgetPasswordUI> createState() => _ForgetPasswordUIState();
}

class _ForgetPasswordUIState extends ConsumerState<ForgetPasswordUI> {
  final email = TextEditingController();
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) =>
          Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
      child: Scaffold(
        appBar: AFBTransparentAppBar(
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
              Text("Tìm tài khoản",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Text("Nhập email của bạn."),
              const SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    label: const Text("Email"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              AFBPrimaryEButton(
                  onPressed: isLocked
                      ? null
                      : () async {
                          setState(() {
                            isLocked = true;
                          });
                          ref.read(authenControllerProvider.notifier).getVerifyCode(
                              email: email.text,
                              onSuccess: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyCodeUI(
                                            mode: VerifyMode.resetpassword, email: email.text)));
                              });
                          () => setState(() {
                                isLocked = false;
                              });
                        },
                  child: Text(isLocked ? "Đang tìm kiếm" : "Tìm tài khoản")),
            ],
          ),
        ),
      ),
    );
  }
}
