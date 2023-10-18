import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class PostReportUI extends StatefulWidget {
  final Post post;
  const PostReportUI({super.key, required this.post});

  @override
  State<PostReportUI> createState() => _PostReportUIState();
}

class _PostReportUIState extends State<PostReportUI> {
  final choice = [
    "Ảnh khỏa thân",
    "Bạo lực",
    "Quấy rối",
    "Tự tử/Tự gây thương tích",
    "Tin giả",
    "Spam",
    "Bán hàng trái phép",
    "Ngôn từ gây thù ghét",
    "Khủng bố"
  ];
  Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: TransparentAppBar(
        title: Text("Báo cáo bài viết", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vui lòng chọn vấn đề để tiếp tục", style: themeData.textTheme.titleMedium),
            Text("Bạn có thể báo cáo bài viết sau khi chọn vấn đề.",
                style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
            Wrap(spacing: 8, children: [
              ...List.generate(
                choice.length,
                (index) => ChoiceChip(
                  selected: selected.contains(choice[index]),
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selected.add(choice[index]);
                      } else {
                        selected.remove(choice[index]);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  label: Text(choice[index]),
                  labelStyle: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Chip(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  label: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.search, size: 16),
                    Text(" Vấn đề khác"),
                  ])),
            ]),
            const Divider(),
            Text("Các bước khác bạn có thể thực hiện", style: themeData.textTheme.titleSmall),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.block),
                    ),
                    Expanded(
                        child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Chặn ${widget.post.author.name}\n",
                          style: themeData.textTheme.titleMedium),
                      TextSpan(
                          text: "Các bạn sẽ không thể nhìn thấy hoặc liên hệ với nhau.",
                          style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    ])))
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: themeData.primaryColor),
                onPressed: selected.isEmpty ? null : () {},
                child: const Center(
                  child: Text("Tiếp"),
                ))
          ],
        ),
      ),
    );
  }
}
