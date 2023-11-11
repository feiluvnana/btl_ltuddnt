import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Game/game_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Market/market_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Menu/menu_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/newsfeed_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Watch/watch_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: TransparentAppBar(
                title: Text(
                  "Anti Fakebook",
                  style: themeData.textTheme.headlineSmall
                      ?.copyWith(color: themeData.primaryColor, fontWeight: FontWeight.bold),
                ),
                bottom:
                    TabBar(controller: tabController, labelPadding: const EdgeInsets.all(8), tabs: [
                  Icon(
                    tabController.index != 0 ? Icons.home_outlined : Icons.home,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  ),
                  Icon(
                    tabController.index != 1 ? Icons.store_outlined : Icons.store,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  ),
                  Icon(
                    tabController.index != 2 ? Icons.tv_outlined : Icons.tv,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  ),
                  Icon(
                    tabController.index != 3
                        ? Icons.videogame_asset_outlined
                        : Icons.videogame_asset,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  ),
                  Icon(
                    tabController.index != 4 ? Icons.notifications_outlined : Icons.notifications,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  ),
                  Icon(
                    tabController.index != 5 ? Icons.menu_outlined : Icons.menu,
                    size: themeData.textTheme.headlineMedium?.fontSize,
                  )
                ])),
            body: TabBarView(controller: tabController, children: const [
              NewsfeedUI(),
              MarketUI(),
              WatchUI(),
              GameUI(),
              Text("Noti"),
              MenuUI()
            ])));
  }
}
