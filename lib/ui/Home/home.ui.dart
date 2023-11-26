import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/friend.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Friend/friend.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/newsfeed.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Watch/watch.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeUI extends ConsumerStatefulWidget {
  const HomeUI({super.key});

  @override
  ConsumerState<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends ConsumerState<HomeUI> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    ref
      ..read(friendControllerProvider.notifier).getSuggestedFriends()
      ..read(newsfeedControllerProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {},
      child: Scaffold(
          appBar: AFBTransparentAppBar(
              title: Text(
                "Anti Fakebook",
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(color: themeData.primaryColor, fontWeight: FontWeight.bold),
              ),
              bottom:
                  TabBar(controller: tabController, labelPadding: const EdgeInsets.all(8), tabs: [
                Icon(
                  tabController.index != 0 ? Icons.home_outlined : Icons.home,
                  size: themeData.textTheme.headlineLarge?.fontSize,
                ),
                Icon(
                  tabController.index != 1 ? Icons.group_outlined : Icons.group,
                  size: themeData.textTheme.headlineLarge?.fontSize,
                ),
                Icon(
                  tabController.index != 2 ? Icons.subscriptions_outlined : Icons.subscriptions,
                  size: themeData.textTheme.headlineLarge?.fontSize,
                ),
                Icon(
                  tabController.index != 3 ? Icons.notifications_outlined : Icons.notifications,
                  size: themeData.textTheme.headlineLarge?.fontSize,
                ),
                Icon(
                  tabController.index != 4 ? Icons.menu_outlined : Icons.menu,
                  size: themeData.textTheme.headlineLarge?.fontSize,
                )
              ])),
          body: TabBarView(
              controller: tabController,
              children: const [NewsfeedUI(), FriendUI(), WatchUI(), Text("Noti"), MenuUI()])),
    );
  }
}
