import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true));
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AFB());
}

class AFB extends StatelessWidget {
  const AFB({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              fontFamilyFallback: ["Roboto", "Helvetica", "NotoColorEmoji"]),
          textTheme: Theme.of(context).textTheme.apply(
              fontFamilyFallback: ["Roboto", "Helvetica", "NotoColorEmoji"]),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          elevatedButtonTheme: const ElevatedButtonThemeData()),
      initialRoute: "/home",
      routes: {
        "/login": (context) => const LoginUI(),
        "/home": (context) => const HomeUI(),
        "/forget": (context) => const ForgetPasswordUI(),
        "/signup": (context) => const SignupUI(),
      },
    );
  }
}
