import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifySignupUI extends StatelessWidget {
  VerifySignupUI({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        bool isPop = false;
        isPop = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "Bạn có chắc chắn muốn thoát không?",
                        style: themeData.textTheme.bodyLarge,
                      ),
                      content: const Text(
                          "Bạn sẽ đăng xuất và sẽ cần xác nhận tài khoản của mình trong lần đăng nhập tiếp theo."),
                      actions: [
                        GestureDetector(
                            onTap: () {
                              Navigator.maybePop(context, false);
                            },
                            child: const Text("HỦY")),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                          },
                          child: Text("THOÁT",
                              style: themeData.textTheme.bodyMedium
                                  ?.copyWith(color: themeData.primaryColor)),
                        )
                      ],
                    )) ??
            false;
        return isPop;
      },
      child: Scaffold(
        appBar: TransparentAppBar(
          title: Text(
            "Nhập mã xác nhận",
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
              Text("Nhập mã xác nhận",
                  style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              BlocBuilder<SignupBloc, SignupState>(
                buildWhen: (previous, current) => previous.email != current.email,
                builder: (context, state) {
                  return Text(
                      "Để xác nhận tài khoản, hãy nhập mã mà chúng tôi đã gửi đến địa chỉ ${state.email}.");
                },
              ),
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: Validators.signupEmailValidator,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      label: const Text("Mã xác nhận"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: themeData.canvasColor,
                      backgroundColor: themeData.primaryColor),
                  onPressed: () {},
                  child: const Text("Tiếp")),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<bool>(
                        shape: const RoundedRectangleBorder(),
                        context: context,
                        builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {},
                                    child: const Row(children: [
                                      Icon(Icons.repeat),
                                      Text(" Gửi lại mã xác nhận")
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.maybePop(context)
                                          .whenComplete(() => Navigator.maybePop(context));
                                    },
                                    child: const Row(
                                        children: [Icon(Icons.arrow_back), Text(" Thoát")]),
                                  ),
                                ),
                              ],
                            ));
                  },
                  child: const Text("Tôi không nhận được mã")),
            ],
          ),
        ),
      ),
    ));
  }
}
