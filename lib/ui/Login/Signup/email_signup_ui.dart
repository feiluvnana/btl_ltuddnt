import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/password_signup_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailSignupUI extends StatelessWidget {
  EmailSignupUI({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Email",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Email của bạn là gì?",
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Text(
                "Nhập email có thể dùng để liên hệ với bạn. Thông tin này sẽ không hiển thị với ai khác trên trang cá nhân của bạn."),
            const SizedBox(height: 10),
            BlocBuilder<SignupBloc, SignupState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: TextFormField(
                    initialValue: state.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.signupEmailValidator,
                    onChanged: (value) {
                      context
                          .read<SignupBloc>()
                          .add(SignupEmailChange(email: value));
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        label: const Text("Email"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                );
              },
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text:
                      "Bạn cũng sẽ nhận được email từ chúng tôi và có thể lựa chọn loại bỏ email bất cứ lúc nào. "),
              TextSpan(
                  text: "Tìm hiểu thêm.",
                  style: themeData.textTheme.bodyMedium
                      ?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ])),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: themeData.primaryColor),
                onPressed: () {
                  if (formKey.currentState?.validate() != true) return;
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<SignupBloc>(context),
                      child: const PasswordSignupUI(),
                    );
                  }));
                },
                child: const Text("Tiếp")),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (route) => false);
                  },
                  child: Text(
                    "Bạn đã có tài khoản ư?",
                    style: themeData.textTheme.bodyLarge?.copyWith(
                        color: themeData.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
