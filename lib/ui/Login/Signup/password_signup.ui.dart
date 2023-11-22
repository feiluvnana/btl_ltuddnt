import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/save_info_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordSignupUI extends StatefulWidget {
  const PasswordSignupUI({super.key});

  @override
  State<PasswordSignupUI> createState() => _PasswordSignupUIState();
}

class _PasswordSignupUIState extends State<PasswordSignupUI> {
  final formKey = GlobalKey<FormState>();
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
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
            BlocBuilder<AuthenBloc, AuthenState>(
              buildWhen: (previous, current) =>
                  previous.signupInfo["password"] != current.signupInfo["password"],
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: TextFormField(
                    initialValue: state.signupInfo["password"],
                    validator: Validators.signupPasswordValidator,
                    obscureText: isHidden,
                    onChanged: (value) {
                      context
                          .read<AuthenBloc>()
                          .add(AuthenSignupInfoChange({...state.signupInfo, "password": value}));
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
                      context, MaterialPageRoute(builder: (_) => const SaveInfoSignupUI()));
                },
                child: const Text("Tiếp")),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                  },
                  child: Text(
                    "Bạn đã có tài khoản ư?",
                    style: themeData.textTheme.bodyLarge
                        ?.copyWith(color: themeData.primaryColor, fontWeight: FontWeight.bold),
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
