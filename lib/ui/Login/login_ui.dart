import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/change_profile_after_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/verify_code.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isHidden = true;
  bool isLocked = false;

  void router(int? active) {
    switch (active) {
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        email.text = "";
        password.text = "";
        break;
      case 0:
        context.read<AuthenBloc>().add(AuthenGetVerifyCode(email.text, () {}));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VerifyCodeUI(email: email.text, mode: VerifyMode.signup)));
        email.text = "";
        password.text = "";
        break;
      case -1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChangeProfileAfterSignupUI()));
        email.text = "";
        password.text = "";
        break;
      case null:
        showAFBDialog(
            context: context,
            title: const Text("Thông báo"),
            content: const Text("Sai tài khoản hoặc mật khẩu!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.maybePop(context), child: const Text("Xác nhận"))
            ]);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Tiếng Việt", style: themeData.textTheme.bodySmall),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: themeData.textTheme.bodySmall?.color,
                        size: themeData.textTheme.bodySmall?.fontSize,
                      )
                    ],
                  ),
                ),
                const Spacer(),
                TextFormField(
                  controller: email,
                  validator: Validators.loginUsernameValidator,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      label: const Text("Số di động hoặc email"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: password,
                  obscureText: isHidden,
                  validator: Validators.loginPasswordValidator,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      label: const Text("Mật khẩu"),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          child: Icon(
                              isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              size: 30)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                BlocBuilder<AuthenBloc, AuthenState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: themeData.canvasColor,
                          backgroundColor: password.text.isNotEmpty && email.text.isNotEmpty
                              ? themeData.primaryColor
                              : null,
                        ),
                        onPressed: (password.text.isNotEmpty && email.text.isNotEmpty && !isLocked)
                            ? () async {
                                if (formKey.currentState?.validate() == true) {
                                  setState(() {
                                    isLocked = true;
                                  });
                                  BlocProvider.of<AuthenBloc>(context).add(AuthenLogin(
                                      email.text,
                                      password.text,
                                      (active) => router(active),
                                      () => setState(() {
                                            isLocked = false;
                                          })));
                                }
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLocked ? const CupertinoActivityIndicator() : const Icon(Icons.login),
                            const Text(" Đăng nhập"),
                          ],
                        ));
                  },
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamedAndRemoveUntil(context, "/forget", (route) => false),
                    child: const Center(child: Text("Bạn quên mật khẩu ư?"))),
                const Spacer(),
                AFBSecondaryEButton(
                    onPressed: () =>
                        Navigator.pushNamedAndRemoveUntil(context, "/signup", (route) => false),
                    child: const Text("Tạo tài khoản mới")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
