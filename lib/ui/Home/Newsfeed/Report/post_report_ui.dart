import 'package:btl_lap_trinh_ung_dung_da_nen_tang/controllers/newsfeed.controller.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/models/post.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Home/Newsfeed/Report/other_problem_ui.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostReportUI extends StatefulWidget {
  final Post post;
  const PostReportUI({super.key, required this.post});

  @override
  State<PostReportUI> createState() => _PostReportUIState();
}

class _PostReportUIState extends State<PostReportUI> {
  final choice = const <(String subject, List<String> detail)>[
    (
      "Ảnh khỏa thân",
      [
        "Ảnh khỏa thân người lớn",
        "Gợi dục",
        "Hoạt động tình dục",
        "Bóc lột tình dục",
        "Dịch vụ tình dục",
        "Ảnh khỏa thân trẻ em",
        "Chia sẻ hình ảnh riêng tư"
      ]
    ),
    (
      "Bạo lực",
      [
        "Hình ảnh bạo lực",
        "Tự vong hoặc bị thương nặng",
        "Mối đe dọa bạo lực",
        "Ngược đãi động vật",
        "Bạo lực tình dục",
        "Vấn đề khác"
      ]
    ),
    ("Quấy rối", ["Tôi", "Một người bạn"]),
    ("Tự tử/Tự gây thương tích", []),
    ("Tin giả", ["Sức khỏe", "Chính trị", "Vấn đề xã hội", "Vấn đề khác"]),
    ("Spam", []),
    (
      "Bán hàng trái phép",
      [
        "Chất cấm, chất gây nghiện",
        "Vũ khí",
        "Động vật có nguy cơ tuyệt chủng",
        "Động vật khác",
        "Vấn đề khác"
      ]
    ),
    (
      "Ngôn từ gây thù ghét",
      [
        "Chủng tộc hoặc sắc tộc",
        "Nguồn gốc quốc gia",
        "Thành phần tôn giáo",
        "Phân chia giai cấp xã hội",
        "Thiên hướng tính dục",
        "Giới tính hoặc bản dạng giới",
        "Tình trạng khuyết tật hoặc bệnh tật",
        "Hạng mục khác"
      ]
    ),
    ("Khủng bố", [])
  ];
  String? subject, detail;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBTransparentAppBar(
        title: Text("Báo cáo bài viết", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
                    selected: subject == choice[index].$1,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          subject = choice[index].$1;
                        } else {
                          subject = null;
                        }
                        detail = null;
                      });
                    },
                    label: Text(choice[index].$1),
                  ),
                ),
                ActionChip(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const OtherProblemUI())),
                    label: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.search, size: 16),
                      Text(" Vấn đề khác"),
                    ])),
              ]),
              const Divider(thickness: 5),
              if (subject != null &&
                  choice.firstWhere((element) => element.$1 == subject).$2.isNotEmpty) ...[
                Text("Vui lòng chọn chi tiết vấn đề để tiếp tục",
                    style: themeData.textTheme.titleMedium),
                Text("Bạn có thể báo cáo bài viết sau khi chọn chi tiết vấn đề.",
                    style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                Wrap(spacing: 8, children: [
                  ...List.generate(
                    choice.firstWhere((element) => element.$1 == subject).$2.length,
                    (index) => ChoiceChip(
                        selected: detail ==
                            choice.firstWhere((element) => element.$1 == subject).$2[index],
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              detail =
                                  choice.firstWhere((element) => element.$1 == subject).$2[index];
                            } else {
                              detail = null;
                            }
                          });
                        },
                        label:
                            Text(choice.firstWhere((element) => element.$1 == subject).$2[index])),
                  )
                ])
              ],
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
              AFBPrimaryEButton(
                  onPressed: subject == null ||
                          (subject != null &&
                              choice.firstWhere((element) => element.$1 == subject).$2.isNotEmpty &&
                              detail == null)
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostReportCompletionUI(
                                      subject: subject!, detail: detail, post: widget.post)));
                        },
                  child: const Center(
                    child: Text("Tiếp"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PostReportCompletionUI extends ConsumerWidget {
  final String subject;
  final String? detail;
  final Post post;
  const PostReportCompletionUI(
      {super.key, required this.subject, required this.detail, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AFBTransparentAppBar(
        title: Text("Báo cáo bài viết", style: themeData.textTheme.titleMedium),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(color: themeData.colorScheme.error, shape: BoxShape.circle),
                child: Icon(Icons.feedback, color: themeData.colorScheme.onError)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Bạn đã chọn", style: themeData.textTheme.titleLarge),
            ),
            ChoiceChip(
                selected: true,
                onSelected: (_) {},
                label: Text(subject),
                labelStyle: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            if (detail != null)
              ChoiceChip(
                  selected: true,
                  onSelected: (_) {},
                  label: Text(detail!),
                  labelStyle:
                      themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text.rich(
              TextSpan(children: [
                const TextSpan(text: "Bạn có thể báo cáo nếu cho rằng nội dung này vi phạm "),
                TextSpan(
                    text: "Tiêu chuẩn cộng đồng",
                    style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                const TextSpan(
                    text:
                        " của chúng tôi. Xin lưu ý rằng đội ngũ xét duyệt của chúng tôi hiện có ít nhân lực hơn.")
              ]),
              textAlign: TextAlign.center,
            ),
            const Divider(thickness: 5),
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
                          text: "Chặn ${post.author.name}\n",
                          style: themeData.textTheme.titleMedium),
                      TextSpan(
                          text: "Các bạn sẽ không thể nhìn thấy hoặc liên hệ với nhau.",
                          style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    ])))
                  ],
                ),
              ),
            ),
            AFBPrimaryEButton(
                onPressed: () {
                  ref
                      .read(newsfeedControllerProvider.notifier)
                      .reportPost(id: post.id, subject: subject, detail: detail ?? "");
                  Navigator.popUntil(context, (route) => route.settings.name == "/home");
                },
                child: const Center(
                  child: Text("Xong"),
                ))
          ],
        ),
      ),
    );
  }
}
