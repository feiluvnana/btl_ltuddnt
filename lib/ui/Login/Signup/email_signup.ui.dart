import 'package:Anti_Fakebook/controllers/authen.controller.dart';
import 'package:Anti_Fakebook/helpers/validators.dart';
import 'package:Anti_Fakebook/ui/Login/Signup/password_signup.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailSignupUI extends ConsumerStatefulWidget {
  const EmailSignupUI({super.key});

  @override
  ConsumerState<EmailSignupUI> createState() => _EmailSignupUIState();
}

class _EmailSignupUIState extends ConsumerState<EmailSignupUI> {
  final formKey = GlobalKey<FormState>();
  String? errText = null;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        title: Text(
          "Email",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Email của bạn là gì?",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text(
                "Nhập email có thể dùng để liên hệ với bạn. Thông tin này sẽ không hiển thị với ai khác trên trang cá nhân của bạn."),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final signupInfo =
                    ref.watch(authenControllerProvider.select((value) => value.value?.signupInfo));
                final email = ref.watch(
                    authenControllerProvider.select((value) => value.value?.signupInfo["email"]));
                return Form(
                  key: formKey,
                  child: TextFormField(
                    initialValue: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    onChanged: (value) {
                      ref
                          .read(authenControllerProvider.notifier)
                          .updateSignupInfo(info: {...signupInfo ?? {}, "email": value});
                    },
                    decoration: InputDecoration(
                        errorText: errText,
                        contentPadding: const EdgeInsets.all(15),
                        label: const Text("Email"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
                      ?.copyWith(color: themeData.colorScheme.primary),
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ])),
            AFBPrimaryEButton(
                onPressed: () async {
                  setState(() {
                    this.errText = null;
                  });
                  if (formKey.currentState?.validate() != true) return;
                  var errText = await ref.read(authenControllerProvider.notifier).checkEmail();
                  if (errText != null) {
                    setState(() {
                      this.errText = errText;
                    });
                    return;
                  }
                  if (mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PasswordSignupUI(),
                        ));
                  }
                },
                child: const Text("Tiếp")),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);

                    ref.read(authenControllerProvider.notifier).updateSignupInfo(info: {});
                  },
                  child: Text(
                    "Bạn đã có tài khoản ư?",
                    style: themeData.textTheme.bodyLarge?.copyWith(
                        color: themeData.colorScheme.primary, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
