import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/email_signup_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/enum.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GenderSignupUI extends StatelessWidget {
  GenderSignupUI({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Giới tính",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Giới tính của bạn là gì?",
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Text(
                "Bạn có thể thay đổi người nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác."),
            const SizedBox(height: 10),
            BlocBuilder<SignupBloc, SignupState>(
              buildWhen: (previous, current) =>
                  previous.gender != current.gender,
              builder: (context, state) {
                return Form(
                    key: formKey,
                    child: FormField<Gender?>(
                      initialValue: state.gender,
                      validator: Validators.signupGenderValidator,
                      builder: (field) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: field.hasError
                                          ? themeData.colorScheme.error
                                          : themeData
                                              .colorScheme.inversePrimary),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text("Nam",
                                            style: themeData
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                      Radio<Gender>(
                                          value: Gender.male,
                                          groupValue: state.gender,
                                          onChanged: (gender) {
                                            if (gender == null) return;
                                            context.read<SignupBloc>().add(
                                                SignupGenderChange(
                                                    gender: gender));
                                          })
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text("Nữ",
                                            style: themeData
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                      Radio<Gender>(
                                          value: Gender.female,
                                          groupValue: state.gender,
                                          onChanged: (gender) {
                                            if (gender == null) return;
                                            context.read<SignupBloc>().add(
                                                SignupGenderChange(
                                                    gender: gender));
                                          }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Trần Xuân Nam",
                                                style: themeData
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const Text(
                                                "Chọn Trần Xuân Nam nếu bạn tHuỘc gIớI tÍnH kHáC hoặc không muốn tiết lộ.")
                                          ],
                                        ),
                                      ),
                                      Radio<Gender>(
                                          value: Gender.tranxuannam,
                                          groupValue: state.gender,
                                          onChanged: (gender) {
                                            if (gender == null) return;
                                            context.read<SignupBloc>().add(
                                                SignupGenderChange(
                                                    gender: gender));
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  field.errorText ?? "",
                                  style: themeData.textTheme.bodySmall
                                      ?.copyWith(
                                          color: themeData.colorScheme.error),
                                ),
                              )
                          ],
                        );
                      },
                    ));
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: themeData.primaryColor),
                onPressed: () {
                  if (formKey.currentState?.validate() != true) return;
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<SignupBloc>(context),
                      child: EmailSignupUI(),
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
                    context.go("/login");
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
