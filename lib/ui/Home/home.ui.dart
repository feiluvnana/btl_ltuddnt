import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/friend.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/search.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/settings.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/profile.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/theme.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/watch.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Friend/friend_requested.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/newsfeed.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Search/search.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Watch/watch.ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeUI extends ConsumerStatefulWidget {
  const HomeUI({super.key});

  @override
  ConsumerState<HomeUI> createState() => HomeUIState();
}

class HomeUIState extends ConsumerState<HomeUI> with TickerProviderStateMixin {
  static late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    ref
      ..read(newsfeedControllerProvider.notifier).init()
      ..read(settingsControllerProvider.notifier).init()
      ..read(profileControllerProvider.notifier).init()
      ..read(friendControllerProvider.notifier).init()
      ..read(searchControllerProvider.notifier).init()
      ..read(watchControllerProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {},
      child: Scaffold(
          appBar: AFBAppBar(
            toolbarHeight: tabController.index == 0 ? 100 : null,
            title: Column(
              children: [
                if (tabController.index == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Anti Fakebook",
                        style: themeData.textTheme.headlineSmall?.copyWith(
                            color: themeData.colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const SearchUI()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.onInverseSurface,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                TabBar(
                    controller: tabController,
                    labelPadding: const EdgeInsets.all(8),
                    onTap: (index) {
                      if (index == 0) {
                        if (NewsfeedUI.ctrl.offset != 0) {
                          NewsfeedUI.ctrl.jumpTo(0);
                        }
                      }
                      ref
                          .read(themeControllerProvider.notifier)
                          .setThemeMode(index == 2 ? ThemeMode.dark : ThemeMode.light);
                    },
                    tabs: [
                      Icon(
                        tabController.index != 0 ? Icons.home_outlined : Icons.home,
                        size: themeData.textTheme.headlineLarge?.fontSize,
                      ),
                      Icon(
                        tabController.index != 1 ? Icons.group_outlined : Icons.group,
                        size: themeData.textTheme.headlineLarge?.fontSize,
                      ),
                      Icon(
                        tabController.index != 2
                            ? Icons.subscriptions_outlined
                            : Icons.subscriptions,
                        size: themeData.textTheme.headlineLarge?.fontSize,
                      ),
                      Icon(
                        tabController.index != 3
                            ? Icons.notifications_outlined
                            : Icons.notifications,
                        size: themeData.textTheme.headlineLarge?.fontSize,
                      ),
                      Icon(
                        tabController.index != 4 ? Icons.menu_outlined : Icons.menu,
                        size: themeData.textTheme.headlineLarge?.fontSize,
                      )
                    ]),
              ],
            ),
          ),
          body: TabBarView(controller: tabController, children: const [
            NewsfeedUI(),
            FriendRequestedUI(),
            WatchUI(),
            Text("Noti"),
            MenuUI()
          ])),
    );
  }
}
