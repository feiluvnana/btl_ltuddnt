import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Report/problem_detail_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_listtile.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';

class OtherProblemUI extends StatelessWidget {
  const OtherProblemUI({super.key});

  final List<String> label = const [
    "Quyền sở hữu trí tuệ",
    "Gian lận hoặc lừa đảo",
    "Chế giễu nạn nhân",
    "Bắt nạt",
    "Lạm dụng trẻ em",
    "Ngược đãi động vật",
    "Hoạt động tình dục",
    "Tự tử hoặc tự gây thương tích",
    "Ngôn từ gây thù ghét",
    "Quảng bá hành vi sử dụng ma túy",
    "Hình ảnh thân mật gợi cảm không có sự đồng thuận",
    "Bóc lột tình dục",
    "Quấy rối",
    "Bán hàng trái phép",
    "Bạo lực",
    "Chia sẻ hình ảnh riêng tư"
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: TransparentAppBar(
        title: Text("Vấn đề khác", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                border: index != label.length - 1
                    ? const Border(bottom: BorderSide(color: Colors.black26))
                    : null),
            child: AFBChevronRightListTile(
              title: label[index],
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProblemDetailUI(index: index))),
            ),
          ),
          itemCount: label.length,
        ),
      ),
    );
  }
}
