import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroUI extends StatelessWidget {
  const IntroUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
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
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        MaterialStatePropertyAll(themeData.primaryColor)),
                onPressed: () {},
                child: const Text("Bắt đầu")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Tôi có tài khoản rồi")),
          ],
        ),
      ),
    ));
  }
}
