import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen.bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/verify_code.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordUI extends StatefulWidget {
  const ForgetPasswordUI({super.key});

  @override
  State<ForgetPasswordUI> createState() => _ForgetPasswordUIState();
}

class _ForgetPasswordUIState extends State<ForgetPasswordUI> {
  final email = TextEditingController();
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) =>
          Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
      child: Scaffold(
        appBar: TransparentAppBar(
          leading: IconButton(
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Tìm tài khoản",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Text("Nhập email của bạn."),
              const SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    label: const Text("Email"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              AFBPrimaryEButton(
                  onPressed: isLocked
                      ? null
                      : () {
                          setState(() {
                            isLocked = true;
                          });
                          context.read<AuthenBloc>().add(AuthenGetVerifyCode(email.text, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyCodeUI(
                                            mode: VerifyMode.resetpassword, email: email.text)));
                              },
                                  () => setState(() {
                                        isLocked = false;
                                      })));
                        },
                  child: Text(isLocked ? "Đang tìm kiếm" : "Tìm tài khoản")),
            ],
          ),
        ),
      ),
    );
  }
}
