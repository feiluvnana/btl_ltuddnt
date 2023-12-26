import 'package:Anti_Fakebook/controllers/settings.controller.dart';
import 'package:Anti_Fakebook/models/blockeduser.model.dart';
import 'package:Anti_Fakebook/widgets/afb_circle_avatar.dart';
import 'package:Anti_Fakebook/widgets/afb_listtile.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsBlockUI extends ConsumerStatefulWidget {
  const SettingsBlockUI({super.key});

  @override
  ConsumerState<SettingsBlockUI> createState() => _SettingsBlockUIState();
}

class _SettingsBlockUIState extends ConsumerState<SettingsBlockUI> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AFBAppBar(
          title: Text("Tất cả bạn bè", style: themeData.textTheme.titleMedium),
          leading: IconButton(
              onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Người bị chặn", style: themeData.textTheme.titleMedium),
              Text(
                  "Một khi bạn đã chặn ai đó, họ sẽ không xem được nội dung bạn tự đăng trên dòng thời gian mình, gắn thẻ bạn, mời bạn tham gia sự kiện hoặc nhóm, bắt đầu cuộc trò chuyện với bạn hay thêm bạn làm bạn bè. Điều này không bao gồm các ứng dụng, trò chơi hay nhóm mà cả bạn hay người này cùng tham gia.",
                  style: themeData.textTheme.bodySmall),
              AFBBottomSheetListTile(
                  onTap: () {}, leading: Icons.search, title: "Thêm vào danh sách chặn"),
              Expanded(child: Builder(builder: (context) {
                var blockedUsers = ref
                    .watch(settingsControllerProvider.select((value) => value.value?.blockedUsers));
                return (blockedUsers?.isNotEmpty == true)
                    ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return SettingsBlockItem(
                            blockedUser: blockedUsers![index],
                          );
                        },
                        itemCount: blockedUsers?.length ?? 0,
                      )
                    : Center(
                        child: Text("Nếu bạn thấy tôi thì hẳn bạn là người rất tốt bụng.",
                            textAlign: TextAlign.center, style: themeData.textTheme.bodyLarge));
              }))
            ],
          ),
        ));
  }
}

class SettingsBlockItem extends ConsumerWidget {
  final BlockedUser blockedUser;

  const SettingsBlockItem({super.key, required this.blockedUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 20,
        child: Row(
          children: [
            AFBCircleAvatar(imageUrl: blockedUser.avatar, radius: 50),
            const SizedBox(width: 10),
            Expanded(child: Text(blockedUser.name, style: themeData.textTheme.titleMedium)),
            TextButton(onPressed: () {}, child: const Text("Bỏ chặn"))
          ],
        ),
      ),
    );
  }
}
