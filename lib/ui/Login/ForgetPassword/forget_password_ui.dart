import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordUI extends StatelessWidget {
  const ForgetPasswordUI({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        leading: IconButton(
            onPressed: () => context.go("/login"),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Tìm tài khoản",
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Text("Nhập số di động của bạn."),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  label: const Text("Số điện thoại"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: themeData.primaryColor),
                onPressed: () {},
                child: const Text("Tìm tài khoản")),
            Center(
              child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Tìm kiếm bằng email",
                    style: themeData.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
