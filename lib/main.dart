import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

var secureStorage =
    const fss.FlutterSecureStorage(aOptions: fss.AndroidOptions(encryptedSharedPreferences: true));
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          return null;
        },
      ));
    }
  }

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
