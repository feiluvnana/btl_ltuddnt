import 'package:Anti_Fakebook/data/data.dart';
import 'package:Anti_Fakebook/widgets/afb_appbar.dart';
import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:flutter/material.dart';

class PostStatusUI extends StatefulWidget {
  const PostStatusUI({super.key});

  @override
  State<PostStatusUI> createState() => _PostStatusUIState();
}

class _PostStatusUIState extends State<PostStatusUI> with TickerProviderStateMixin {
  late final ctrl = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
        title: Text("Bạn đang cảm thấy thế nào", style: themeData.textTheme.titleMedium),
      ),
      body: Column(children: [
        TabBar(
            controller: ctrl,
            tabs: const [Tab(child: Text("Cảm xúc")), Tab(child: Text("Hoạt động"))]),
        Expanded(
            child: TabBarView(controller: ctrl, children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3.0),
            itemCount: processedData.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, processedData[index]["name"]);
                },
                child: Row(children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AFBNetworkImage(url: processedData[index]["uri"]),
                    ),
                  ),
                  Expanded(child: Text(processedData[index]["name"], maxLines: null))
                ]),
              );
            },
          ),
          const Center(child: Text("Tính năng đang được phát triển"))
        ]))
      ]),
    );
  }
}
