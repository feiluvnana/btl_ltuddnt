import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/name_signup_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupUI extends StatelessWidget {
  const SignupUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
            appBar: TransparentAppBar(
              title: Text(
                "Tạo tài khoản",
                style: themeData.textTheme.titleMedium,
              ),
              leading: IconButton(
                  onPressed: () => context.go("/login"),
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Tham gia Anti Fakebook",
                      style: themeData.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const FlutterLogo(size: 100),
                  const Text(
                      "Tạo tài khoản để kết nối với bạn bè, người thân và cộng đồng có chung sở thích."),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: themeData.primaryColor),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<SignupBloc>(context),
                            child: NameSignupUI(),
                          );
                        }));
                      },
                      child: const Text("Bắt đầu")),
                  ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Tôi có tài khoản rồi")),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
