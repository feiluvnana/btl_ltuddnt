import 'package:Anti_Fakebook/controllers/notification.controller.dart';
import 'package:Anti_Fakebook/helpers/text_formater.dart';
import 'package:Anti_Fakebook/models/notification.model.dart';
import 'package:Anti_Fakebook/ui/Home/Friend/friend_all.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Newsfeed/Post/post_query.ui.dart';
import 'package:Anti_Fakebook/ui/Home/Search/search.ui.dart';
import 'package:Anti_Fakebook/ui/Home/home.ui.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotiUI extends ConsumerStatefulWidget {
  const NotiUI({super.key});

  @override
  ConsumerState<NotiUI> createState() => _NotiUIState();
}

class _NotiUIState extends ConsumerState<NotiUI> {
  final ctrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(body: Builder(builder: (context) {
      var notifications = ref.watch(notificationControllerProvider).value?.notifications;
      return RefreshIndicator(
        onRefresh: () async {
          ref.read(notificationControllerProvider.notifier).refreshNotification();
        },
        child: (notifications == null)
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Center(child: Text("Đang tải..."))),
              )
            : ListView.builder(
                controller: ctrl
                  ..addListener(() {
                    if (ctrl.offset >=
                        ctrl.position.maxScrollExtent - MediaQuery.sizeOf(context).height / 2) {
                      ref.read(notificationControllerProvider.notifier).getNotification();
                    }
                  }),
                itemBuilder: (context, index) => index == 0
                    ? Row(
                        children: [
                          const SizedBox(width: 10),
                          Text("Thông báo",
                              style: themeData.textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const SearchUI()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.onInverseSurface,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.search),
                            ),
                          )
                        ],
                      )
                    : index == notifications.length + 1
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: ref
                                        .read(notificationControllerProvider.notifier)
                                        .lockFetchNotifications
                                    ? const Text("Đã hết thông báo.")
                                    : const CircularProgressIndicator()),
                          )
                        : NotificationTile(notification: notifications[index - 1]),
                itemCount: 2 + notifications.length),
      );
    }));
  }
}

class NotificationTile extends StatelessWidget {
  final Notification notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        // context
        //     .showAFBDialog(
        //         title: const Text(""), actions: [], content: Text(notification.toJson().toString()))
        //     .then((value) {
        if (notification.group == 1) {
          switch (notification.type) {
            case 1:
              HomeUIState.pageController.jumpToPage(1);
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FriendAllUI(),
                      settings: RouteSettings(arguments: notification.objectId)));
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostQueryUI(postId: notification.objectId)));
          }
        }
        // });
      },
      child: ListTile(
        tileColor: notification.read ? null : themeData.colorScheme.primaryContainer,
        leading: AFBCircleAvatar(imageUrl: notification.avatar),
        title: switch (notification.type) {
          1 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã gửi lời mời kết bạn tới bạn.", style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          2 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã chấp nhận lời mời kết bạn từ bạn.",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          3 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã đăng một bài viết mới: ${notification.post?["described"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          4 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã sửa một bài viết mới: ${notification.post?["described"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          5 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        " đã ${notification.feel?["type"].toString() == "1" ? "kudos" : "disappointed"} một bài viết: ${notification.post?["described"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          6 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã mark một bài viết: ${notification.mark?["mark_content"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          7 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã bình luận một mark: ${notification.mark?["mark_content"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          8 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã đăng một video mới: ${notification.post?["described"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          9 => Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: notification.user.username,
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " đã bình luận một bài viết: ${notification.mark?["mark_content"]}",
                    style: themeData.textTheme.bodySmall),
              ]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          _ => Text(notification.title,
              style: themeData.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        },
        subtitle:
            Text(formatNotiCreatedTime(notification.created), style: themeData.textTheme.bodySmall),
        splashColor: themeData.colorScheme.onPrimary,
      ),
    );
  }
}
