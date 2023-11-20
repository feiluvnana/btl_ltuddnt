import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/agreement_signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveInfoSignupUI extends StatelessWidget {
  const SaveInfoSignupUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Lưu thông tin đăng nhập",
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
            Text("Lưu thông tin đăng nhập?",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            // Text(
            //     "Chúng tôi sẽ lưu thông tin đăng nhập cho ${state.lastName} ${state.firstName} để bạn không cần nhập vào lần sau."),
            const Text(
                "Chúng tôi sẽ lưu thông tin đăng nhập cho bạn để bạn không cần nhập vào lần sau."),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.canvasColor,
                    backgroundColor: themeData.primaryColor),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<SignupBloc>(context),
                      child: const AgreementSignupUI(),
                    );
                  }));
                },
                child: const Text("Lưu")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<SignupBloc>(context),
                      child: const AgreementSignupUI(),
                    );
                  }));
                },
                child: const Text("Lúc khác")),
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
