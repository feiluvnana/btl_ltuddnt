import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/authen.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/friend.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/profile.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/search.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/settings.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension WRExtension on AsyncNotifierProviderRef {
  void reset() {
    read(friendControllerProvider.notifier).reset();
    read(newsfeedControllerProvider.notifier).reset();
    read(authenControllerProvider.notifier).logout();
    read(profileControllerProvider.notifier).reset();
    read(searchControllerProvider.notifier).reset();
    read(settingsControllerProvider.notifier).reset();
    navigatorKey.currentState!.pushNamedAndRemoveUntil("/login", (route) => false);
  }
}
