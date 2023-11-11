import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var secureStorage =
    const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AFB());
}

class AFB extends StatelessWidget {
  const AFB({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenBloc(),
      child: BlocProvider(
        create: (context) => SignupBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
              primaryTextTheme: Theme.of(context)
                  .primaryTextTheme
                  .apply(fontFamilyFallback: ["Roboto", "Helvetica", "NotoColorEmoji"]),
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(
                      titleMedium: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500))
                  .apply(fontFamilyFallback: ["Roboto", "Helvetica", "NotoColorEmoji"]),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              elevatedButtonTheme: const ElevatedButtonThemeData()),
          initialRoute: "/login",
          routes: {
            "/login": (context) => const LoginUI(),
            "/home": (context) => const HomeUI(),
            "/forget": (context) => const ForgetPasswordUI(),
            "/signup": (context) => const SignupUI(),
          },
        ),
      ),
    );
  }
}
