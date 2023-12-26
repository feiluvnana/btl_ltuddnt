import 'dart:async';
import 'dart:convert';

import 'package:Anti_Fakebook/controllers/extension.dart';
import 'package:Anti_Fakebook/models/notification.model.dart';
import 'package:Anti_Fakebook/services/apis/api.dart';
import 'package:Anti_Fakebook/ui/Home/home.ui.dart';
import 'package:Anti_Fakebook/values/response_code.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification.controller.freezed.dart';
part 'notification.controller.g.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({List<Notification>? notifications, @Default(0) int badge}) =
      _NotificationState;
}

@pragma("vm:entry-point")
Future<void> onBackgroundMessageHandler(RemoteMessage msg) async {}

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  bool canFetchNotifications = true;
  bool lockFetchNotifications = false;
  StreamSubscription? subOnMessage;

  @override
  FutureOr<NotificationState> build() {
    return const NotificationState();
  }

  void init() {
    // FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      HomeUIState.pageController.jumpToPage(3);
      HomeUIState.tabController.index = 3;
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value == null) return;
      HomeUIState.pageController.jumpToPage(3);
      HomeUIState.tabController.index = 3;
    });
    subOnMessage = FirebaseMessaging.onMessage.listen((event) {
      Notification noti = Notification.fromJson(jsonDecode(event.data["json"]));
      var index = state.value?.notifications?.indexOf(noti);
      if (index == -1) {
        state = AsyncValue.data(state.value!.copyWith(
            notifications: [noti, ...state.value!.notifications!], badge: state.value!.badge + 1));
      } else if (index != 0) {
        state = AsyncValue.data(state.value!.copyWith(
            notifications: state.value!.notifications!
                .map((e) => e.notificationId == noti.notificationId ? noti : e)
                .toList()));
      }
    });
    getNotification();
  }

  void refreshNotification() {
    state = const AsyncValue.data(NotificationState());
    canFetchNotifications = true;
    lockFetchNotifications = false;
    getNotification();
  }

  Future<void> getNotification() async {
    if (!canFetchNotifications || lockFetchNotifications) return;
    canFetchNotifications = false;
    await Api().getNotification(state.requireValue.notifications?.length ?? 0).then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: "Có lỗi với máy chủ. Hãy thử lại sau.");
      } else if (value["code"] == "9998") {
        ref.reset();
      } else if (value["code"] != "1000") {
        Fluttertoast.showToast(msg: resCode[value["code"]] ?? "Lỗi không xác định.");
      } else {
        if (value["data"].length < 15) {
          lockFetchNotifications = true;
        }
        state = AsyncValue.data(state.requireValue.copyWith(notifications: [
          ...state.value?.notifications ?? [],
          ...(value["data"] as List).map((e) => Notification.fromJson(e))
        ], badge: int.parse(value["badge"])));
      }
    });
    canFetchNotifications = !canFetchNotifications;
  }
}
