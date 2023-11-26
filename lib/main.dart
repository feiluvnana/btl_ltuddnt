import 'dart:convert';
import 'dart:io';

import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/user.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/Settings/settings.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/home.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/ForgetPassword/forget_password.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/signup.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/login.ui.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

const secureStorage =
    fss.FlutterSecureStorage(aOptions: fss.AndroidOptions(encryptedSharedPreferences: true));
final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
const afbAppRetain = MethodChannel("afb_app_retain");

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  var initialRoute = "/login";
  User? initialUser;
  await secureStorage.read(key: "user").then((value) {
    if (value != null) {
      initialUser = User.fromJson(jsonDecode(value));
      initialRoute = initialUser?.token == null ? "/login" : "/home";
    }
  });
  // await secureStorage.read(key: "posts").then((value) {
  //   if (value != null) {
  //     initialPosts = (jsonDecode(value) as List).map<Post>((e) => Post.fromJson(e)).toList();
  //   }
  // });
  runApp(AFB(initialRoute: initialRoute));
  FlutterNativeSplash.remove();
}

class AFB extends StatelessWidget {
  final String initialRoute;
  const AFB({super.key, required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DevicePreview(builder: (context) {
        Connectivity().onConnectivityChanged.listen((result) {
          if (result != ConnectivityResult.wifi && result != ConnectivityResult.mobile) {
            scaffoldMessengerKey.currentState!.showMaterialBanner(MaterialBanner(
                content: const Text("❌ Không có kết nối Internet"),
                actions: const [Text("")],
                backgroundColor: Theme.of(context).colorScheme.errorContainer));
          } else {
            scaffoldMessengerKey.currentState!.clearMaterialBanners();
          }
        });
        Future.delayed(
            const Duration(seconds: 1),
            () => Connectivity().checkConnectivity().then((result) {
                  if (result != ConnectivityResult.wifi && result != ConnectivityResult.mobile) {
                    scaffoldMessengerKey.currentState!.showMaterialBanner(MaterialBanner(
                        content: const Text("❌ Không có kết nối Internet"),
                        actions: const [Text("")],
                        backgroundColor: Theme.of(context).colorScheme.errorContainer));
                  }
                }));
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: ThemeData(
                chipTheme: Theme.of(context).chipTheme.copyWith(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(5)),
                primaryTextTheme: Theme.of(context)
                    .primaryTextTheme
                    .copyWith(
                        titleMedium: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        titleLarge: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w500))
                    .apply(fontFamilyFallback: ["Roboto", "NotoColorEmoji"]),
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(
                        titleMedium: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        titleLarge: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w500))
                    .apply(fontFamilyFallback: ["Roboto", "NotoColorEmoji"]),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
                elevatedButtonTheme: const ElevatedButtonThemeData()),
            initialRoute: initialRoute,
            routes: {
              "/login": (context) => const LoginUI(),
              "/home": (context) => const HomeUI(),
              "/forget": (context) => const ForgetPasswordUI(),
              "/signup": (context) => const SignupUI(),
              "/settings": (context) => const SettingsUI()
            },
          ),
        );
      }),
    );
  }
}
