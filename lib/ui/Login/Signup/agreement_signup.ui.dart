import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen.bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/verify_code.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgreementSignupUI extends StatefulWidget {
  const AgreementSignupUI({super.key});

  @override
  State<AgreementSignupUI> createState() => _AgreementSignupUIState();
}

class _AgreementSignupUIState extends State<AgreementSignupUI> {
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Đồng ý với điều khoản và chính sách của Anti Fakebook",
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
            Text("Đồng ý với điều khoản và chính sách của Anti Fakebook",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text:
                      "Những người dùng dịch vụ của chúng tôi có thể đã tải thông tin liên hệ của bạn lên Anti Fakebook. "),
              TextSpan(
                  text: "Tìm hiểu thêm.",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ])),
            const SizedBox(height: 10),
            Text.rich(TextSpan(children: [
              const TextSpan(text: "Bằng cách nhấn vào "),
              TextSpan(
                  text: "Tôi đồng ý, ",
                  style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              const TextSpan(text: "bạn đồng ý tạo tài khoản, cũng như chấp thuận "),
              TextSpan(
                  text: "Điều khoản",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              const TextSpan(text: ", "),
              TextSpan(
                  text: "Chính sách quyền riêng tư",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              const TextSpan(text: " và "),
              TextSpan(
                  text: "Chính sách cookie",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              const TextSpan(text: " của Anti Fakebook."),
            ])),
            const SizedBox(height: 10),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Chính sách quyền riêng tư",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              const TextSpan(
                  text:
                      " mô tả các cách chúng tôi có thể dùng thông tin thu thập được khi bạn tạo tài khoản. Chẳng hạn, chúng tôi sử dụng thông tin này để cung cấp, cá nhân hóa và cải thiện các sản phẩm của mình, bao gồm quảng cáo."),
            ])),
            const SizedBox(height: 10),
            AFBPrimaryEButton(
                onPressed: isLocked
                    ? null
                    : () {
                        setState(() {
                          isLocked = true;
                        });
                        context.read<AuthenBloc>().add(AuthenSignupRequest(
                            () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VerifyCodeUI(
                                        email:
                                            context.read<AuthenBloc>().state.signupInfo["email"]!,
                                        mode: VerifyMode.signup)),
                                (route) => false),
                            () => setState(() {
                                  isLocked = false;
                                })));
                      },
                child: const Text("Tôi đồng ý")),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
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
    );
  }
}
