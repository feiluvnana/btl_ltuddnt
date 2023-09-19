import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: TransparentAppBar(),
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
                  validator: Validators.loginUsernameValidator,
                  decoration: InputDecoration(
                      hintText: "Số di động hoặc email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  validator: Validators.loginPasswordValidator,
                  decoration: InputDecoration(
                      hintText: "Mật khẩu",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        backgroundColor:
                            MaterialStatePropertyAll(themeData.primaryColor)),
                    onPressed: () {
                      formKey.currentState?.validate();
                      Navigator.pushReplacementNamed(context, "/home");
                    },
                    child: const Text("Đăng nhập")),
                GestureDetector(
                    child: const Center(child: Text("Bạn quên mật khẩu ư?"))),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Tạo tài khoản mới")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
