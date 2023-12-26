import 'package:Anti_Fakebook/controllers/authen.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/helpers/validators.dart';
import 'package:Anti_Fakebook/main.dart';
import 'package:Anti_Fakebook/ui/Login/Signup/change_profile_after_signup.ui.dart';
import 'package:Anti_Fakebook/ui/Login/verify_code.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_button.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_popup.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUI extends ConsumerStatefulWidget {
  const LoginUI({super.key});

  @override
  ConsumerState<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends ConsumerState<LoginUI> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isHidden = true;
  bool isLocked = false;

  void router(int? active) {
    switch (active) {
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        email.text = "";
        password.text = "";
        break;
      case 0:
        ref.read(authenControllerProvider.notifier).getVerifyCode(email: email.text);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VerifyCodeUI(email: email.text, mode: VerifyMode.signup)));
        email.text = "";
        password.text = "";
        break;
      case -1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChangeProfileAfterSignupUI()));
        email.text = "";
        password.text = "";
        break;
      case null:
        context.showAFBDialog(
            title: const Text("Thông báo"),
            content: const Text("Sai tài khoản hoặc mật khẩu!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.maybePop(context), child: const Text("Xác nhận"))
            ]);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          afbAppRetain.invokeMethod("sendToBackground");
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Builder(
              builder: (context) {
                final profile =
                    ref.watch(profileControllerProvider.select((value) => value.value?.profile));
                return (profile != null)
                    ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const FlutterLogo(size: 110),
                        const SizedBox(height: 30),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const LoginPasswordUI()));
                          },
                          leading: AFBCircleAvatar(imageUrl: profile.avatar, radius: 60),
                          title: Text(profile.username, style: themeData.textTheme.titleMedium),
                          trailing: PopupMenuButton(
                              itemBuilder: (context) => <PopupMenuEntry>[
                                    PopupMenuItem(
                                      onTap: () => ref
                                          .read(authenControllerProvider.notifier)
                                          .deleteAccount(),
                                      child: const Text("Xóa tài khoản khỏi thiết bị"),
                                    ),
                                  ]),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        const SizedBox(height: 30),
                        AFBBottomSheetListTile(
                            onTap: () {
                              ref.read(authenControllerProvider.notifier).deleteAccount();
                            },
                            leading: Icons.add,
                            title: "Đăng nhập bằng tài khoản khác"),
                        AFBBottomSheetListTile(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/signup", (route) => false);
                            },
                            leading: Icons.app_registration,
                            title: "Đăng ký tài khoản Anti Fakebook")
                      ])
                    : Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Tiếng Việt", style: themeData.textTheme.bodySmall),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: themeData.textTheme.bodySmall?.color,
                                    size: themeData.textTheme.bodySmall?.fontSize,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextFormField(
                              controller: email,
                              validator: Validators.email,
                              onChanged: (value) => setState(() {}),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  label: const Text("Số di động hoặc email"),
                                  border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: password,
                              obscureText: isHidden,
                              validator: Validators.password,
                              onChanged: (value) => setState(() {}),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  label: const Text("Mật khẩu"),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: Icon(
                                          isHidden
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 30)),
                                  border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: themeData.colorScheme.onPrimary,
                                  backgroundColor: password.text.isNotEmpty && email.text.isNotEmpty
                                      ? themeData.colorScheme.primary
                                      : null,
                                ),
                                onPressed:
                                    (password.text.isNotEmpty && email.text.isNotEmpty && !isLocked)
                                        ? () async {
                                            if (formKey.currentState?.validate() == true) {
                                              setState(() {
                                                isLocked = true;
                                              });
                                              await ref
                                                  .read(authenControllerProvider.notifier)
                                                  .login(email: email.text, password: password.text)
                                                  .then((value) => router(value));
                                              setState(() => isLocked = false);
                                            }
                                          }
                                        : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLocked
                                        ? const CupertinoActivityIndicator()
                                        : const Icon(Icons.login),
                                    const Text(" Đăng nhập"),
                                  ],
                                )),
                            TextButton(
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                    context, "/forget", (route) => false),
                                child: const Center(child: Text("Bạn quên mật khẩu ư?"))),
                            const Spacer(),
                            AFBSecondaryEButton(
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                    context, "/signup", (route) => false),
                                child: const Text("Tạo tài khoản mới")),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPasswordUI extends ConsumerStatefulWidget {
  const LoginPasswordUI({super.key});

  @override
  ConsumerState<LoginPasswordUI> createState() => _LoginPasswordUIState();
}

class _LoginPasswordUIState extends ConsumerState<LoginPasswordUI> {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  var isLocked = false;
  var isHidden = true;

  void router(int? active) {
    switch (active) {
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        password.text = "";
        break;
      case 0:
        ref.read(authenControllerProvider.notifier).getVerifyCode(email: null);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => VerifyCodeUI(
                    email: ref.read(authenControllerProvider).requireValue.user!.email!,
                    mode: VerifyMode.signup)));
        password.text = "";
        break;
      case -1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChangeProfileAfterSignupUI()));
        password.text = "";
        break;
      case null:
        context.showAFBDialog(
            title: const Text("Thông báo"),
            content: const Text("Sai mật khẩu!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.maybePop(context), child: const Text("Xác nhận"))
            ]);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AFBAppBar(
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back))),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Builder(
          builder: (context) {
            final profile =
                ref.watch(profileControllerProvider.select((value) => value.value?.profile));
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AFBCircleAvatar(imageUrl: profile?.avatar ?? "", radius: 72),
                  const SizedBox(height: 15),
                  Text(profile!.username, style: themeData.textTheme.titleLarge),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: isHidden,
                    controller: password,
                    validator: Validators.password,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        label: const Text("Mật khẩu"),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: Icon(
                                isHidden
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 30)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: themeData.colorScheme.onPrimary,
                          backgroundColor: themeData.colorScheme.primary),
                      onPressed: (!isLocked && password.text.isNotEmpty)
                          ? () async {
                              if (formKey.currentState?.validate() == true) {
                                setState(() {
                                  isLocked = true;
                                });
                                await ref
                                    .read(authenControllerProvider.notifier)
                                    .login(
                                        email:
                                            ref.read(authenControllerProvider).value!.user!.email!,
                                        password: password.text)
                                    .then((value) => router(value));
                                setState(() => isLocked = false);
                              }
                            }
                          : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLocked ? const CupertinoActivityIndicator() : const Icon(Icons.login),
                          const Text(" Đăng nhập"),
                        ],
                      )),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamedAndRemoveUntil(context, "/forget", (route) => false),
                      child: const Center(child: Text("Bạn quên mật khẩu ư?"))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
