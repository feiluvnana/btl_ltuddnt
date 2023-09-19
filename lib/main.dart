import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/login_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AFB());
}

class AFB extends StatelessWidget {
  const AFB({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        "/login": (context) => const LoginUI(),
        "/home": (context) => const HomeUI()
      },
      initialRoute: "/login",
    );
  }
}
