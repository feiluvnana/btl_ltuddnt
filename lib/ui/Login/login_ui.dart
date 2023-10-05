import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isHidden = true;

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
                  controller: _username,
                  validator: Validators.loginUsernameValidator,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      label: const Text("Số di động hoặc email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _password,
                  obscureText: isHidden,
                  validator: Validators.loginPasswordValidator,
                  onChanged: (value) {
                    setState(() {});
                  },
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
                              isHidden
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 30)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          _password.text.isNotEmpty && _username.text.isNotEmpty
                              ? themeData.primaryColor
                              : null,
                    ),
                    onPressed:
                        (_password.text.isNotEmpty && _username.text.isNotEmpty)
                            ? () async {
                                if (formKey.currentState?.validate() != true) {
                                  return;
                                }
                                context.go("/home");
                              }
                            : null,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login),
                        Text(" Đăng nhập"),
                      ],
                    )),
                GestureDetector(
                    onTap: () {
                      context.go("/forget");
                    },
                    child: const Center(child: Text("Bạn quên mật khẩu ư?"))),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      context.go("/signup");
                    },
                    child: const Text("Tạo tài khoản mới")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
