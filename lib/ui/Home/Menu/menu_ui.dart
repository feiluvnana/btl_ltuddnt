import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_header.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_help_center.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_profile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_settings.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuUI extends StatelessWidget {
  const MenuUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          MenuHeader(),
          MenuProfile(),
          Divider(indent: 10, endIndent: 10),
          MenuShortcuts(),
          Divider(indent: 10, endIndent: 10),
          MenuHelpCenter(),
          Divider(indent: 10, endIndent: 10),
          MenuSettings(),
          _MenuLogoutButton()
        ],
      ),
    );
  }
}

class _MenuLogoutButton extends StatelessWidget {
  const _MenuLogoutButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 2,
            surfaceTintColor: Colors.black26),
        onPressed: () {
          context.go("/login");
        },
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Đăng xuất")]),
      ),
    );
  }
}
