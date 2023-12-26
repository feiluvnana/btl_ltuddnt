import 'package:Anti_Fakebook/controllers/authen.controller.dart';
import 'package:Anti_Fakebook/controllers/friend.controller.dart';
import 'package:Anti_Fakebook/controllers/newsfeed.controller.dart';
import 'package:Anti_Fakebook/controllers/notification.controller.dart';
import 'package:Anti_Fakebook/controllers/profile.controller.dart';
import 'package:Anti_Fakebook/controllers/search.controller.dart';
import 'package:Anti_Fakebook/controllers/settings.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension WRExtension on AsyncNotifierProviderRef {
  void reset() {
    read(notificationControllerProvider.notifier).subOnMessage?.cancel();
    read(friendControllerProvider.notifier).reset();
    read(newsfeedControllerProvider.notifier).reset();
    read(authenControllerProvider.notifier).logout();
    read(profileControllerProvider.notifier).reset();
    read(searchControllerProvider.notifier).reset();
    read(settingsControllerProvider.notifier).reset();
  }
}
