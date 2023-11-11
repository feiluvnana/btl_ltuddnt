// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("SignupUI", () {
    testWidgets('Back', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(BlocProvider(
        create: (context) => AuthenBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: "/signup",
          routes: {
            "/login": (context) => const LoginUI(),
            "/home": (context) => const HomeUI(),
            "/forget": (context) => const ForgetPasswordUI(),
            "/signup": (context) => const SignupUI(),
          },
        ),
      ));

      expect(find.text("Tôi có tài khoản rồi"), findsOneWidget, reason: "Must have button");
      expect(find.byType(LoginUI), findsNothing, reason: "Not in login screen");

      await tester.tap(find.text("Tôi có tài khoản rồi"));
      await tester.pump();
      await tester.pump();
      await tester.pump();

      debugDumpApp();
      expect(find.byType(LoginUI), findsOneWidget, reason: "In login screen");
    });
  });
}
