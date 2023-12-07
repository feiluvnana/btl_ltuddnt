import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/change_profile_after_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VerifyMode { signup, resetpassword }

class VerifyCodeUI extends ConsumerStatefulWidget {
  final VerifyMode mode;
  final String email;
  const VerifyCodeUI({super.key, required this.mode, required this.email});

  @override
  ConsumerState<VerifyCodeUI> createState() => _VerifyCodeUIState();
}

class _VerifyCodeUIState extends ConsumerState<VerifyCodeUI> {
  final code = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    Future<bool> decideCanPop() async {
      return await context.showAFBDialog<bool>(
            title: Text(
              "Bạn có chắc chắn muốn thoát không?",
              style: themeData.textTheme.bodyLarge,
            ),
            content: Text(widget.mode == VerifyMode.signup
                ? "Bạn sẽ đăng xuất và sẽ cần xác nhận tài khoản của mình trong lần đăng nhập tiếp theo."
                : "Bạn sẽ phải thực hiện lại bước này nếu muốn đặt lại mật khẩu."),
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.maybePop(context, false);
                  },
                  child: const Text("HỦY")),
              GestureDetector(
                onTap: () {
                  ref.read(authenControllerProvider.notifier).logout();
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                  ref.read(authenControllerProvider.notifier).updateSignupInfo(info: {});
                },
                child: Text("THOÁT",
                    style: themeData.textTheme.bodyMedium
                        ?.copyWith(color: themeData.colorScheme.primary)),
              )
            ],
          ) ??
          false;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => decideCanPop().then((value) {
        if (value) Navigator.pop(context);
      }),
      child: Scaffold(
        appBar: AFBAppBar(
          title: Text(
            widget.mode == VerifyMode.signup ? "Nhập mã xác nhận" : "Đặt lại mật khẩu",
            style: themeData.textTheme.titleMedium,
          ),
          leading: IconButton(
              onPressed: () => decideCanPop().then((value) {
                    if (value) Navigator.pop(context);
                  }),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Nhập mã xác nhận",
                    style:
                        themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                Text(
                    "Để ${widget.mode == VerifyMode.signup ? "xác nhận tài khoản" : "đặt lại mật khẩu"}, hãy nhập mã mà chúng tôi đã gửi đến địa chỉ ${widget.email}."),
                const SizedBox(height: 10),
                TextFormField(
                  controller: code,
                  validator: Validators.verifyCodeValidator,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      label: const Text("Mã xác nhận"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                if (widget.mode == VerifyMode.resetpassword) const SizedBox(height: 10),
                if (widget.mode == VerifyMode.resetpassword)
                  TextFormField(
                    controller: password,
                    validator: Validators.passwordValidator,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        label: const Text("Mật khẩu mới"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                AFBPrimaryEButton(
                    onPressed: isLocked
                        ? null
                        : () async {
                            if (formKey.currentState?.validate() != true) return;
                            setState(() => isLocked = true);
                            if (widget.mode == VerifyMode.resetpassword) {
                              await ref.read(authenControllerProvider.notifier).resetPassword(
                                  email: widget.email, code: code.text, password: password.text);
                              if (mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/login", (route) => false);
                              }
                            } else {
                              await ref.read(authenControllerProvider.notifier).checkVerifyCode(
                                  email: widget.email,
                                  code: code.text,
                                  onSuccess: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const ChangeProfileAfterSignupUI()),
                                        (route) => false);
                                  });
                            }
                            setState(() => isLocked = false);
                          },
                    child: const Text("Tiếp")),
                ElevatedButton(
                    onPressed: () {
                      context.showAFBOptionModalBottomSheet<bool>(
                        blocks: [
                          [
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.maybePop(context);
                                  ref
                                      .read(authenControllerProvider.notifier)
                                      .getVerifyCode(email: widget.email);
                                },
                                leading: Icons.repeat,
                                title: "Gửi lại mã xác nhận"),
                            AFBBottomSheetListTile(
                                onTap: () {
                                  Navigator.maybePop(context)
                                      .whenComplete(() => decideCanPop().then((value) {
                                            if (value) Navigator.pop(context);
                                          }));
                                },
                                leading: Icons.arrow_back,
                                title: "Thoát"),
                          ]
                        ],
                      );
                    },
                    child: const Text("Tôi không nhận được mã")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
