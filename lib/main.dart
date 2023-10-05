import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

var secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AFB());
}

GoRouter router = GoRouter(initialLocation: "/login", routes: [
  GoRoute(path: "/login", builder: (context, state) => const LoginUI()),
  GoRoute(path: "/home", builder: (context, state) => const HomeUI()),
  GoRoute(
      path: "/forget", builder: (context, state) => const ForgetPasswordUI()),
  GoRoute(path: "/signup", builder: (context, state) => const SignupUI())
]);

class AFB extends StatelessWidget {
  const AFB({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          elevatedButtonTheme: const ElevatedButtonThemeData()),
      routerConfig: router,
    );
  }
}
