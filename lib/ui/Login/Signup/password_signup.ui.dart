import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/agreement_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordSignupUI extends ConsumerStatefulWidget {
  const PasswordSignupUI({super.key});

  @override
  ConsumerState<PasswordSignupUI> createState() => _PasswordSignupUIState();
}

class _PasswordSignupUIState extends ConsumerState<PasswordSignupUI> {
  final formKey = GlobalKey<FormState>();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        title: Text(
          "Mật khẩu",
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
            Text("Tạo mật khẩu",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text(
                "Tạo mật khẩu gồm <wait_for_description>. Bạn nên chọn mật khẩu thật khó đoán."),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                final signupInfo =
                    ref.watch(authenControllerProvider.select((value) => value.value?.signupInfo));
                final password = ref.watch(authenControllerProvider
                    .select((value) => value.value?.signupInfo["password"]));
                return Form(
                  key: formKey,
                  child: TextFormField(
                    initialValue: password,
                    validator: Validators.passwordValidator,
                    obscureText: isHidden,
                    onChanged: (value) {
                      ref
                          .read(authenControllerProvider.notifier)
                          .updateSignupInfo(info: {...signupInfo ?? {}, "password": value});
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                );
              },
            ),
            AFBPrimaryEButton(
                onPressed: () {
                  if (formKey.currentState?.validate() != true) return;
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const AgreementSignupUI()));
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
