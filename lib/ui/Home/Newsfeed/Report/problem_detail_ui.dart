import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_appbar.dart';
import 'package:flutter/material.dart';

class ProblemDetailUI extends StatelessWidget {
  final int index;
  const ProblemDetailUI({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Text detail = switch (index) {
      (>= 0 && <= 3) || (>= 10 && <= 11) when index != 1 => Text.rich(TextSpan(children: [
          TextSpan(
              text: "Nội dung này có vi phạm tiêu chuẩn cộng đồng của chúng tôi không?\n",
              style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  "Các tiêu chuẩn của chúng tôi giải thích về những gì chúng tôi cho phép và không cho phép hiển thị trên Anti Fakebook. Với sự hỗ trợ của các chuyên gia, chúng tôi thường xuyên xem xét và cập nhật các tiêu chuẩn mình đề ra.\n",
              style: themeData.textTheme.bodyMedium),
          TextSpan(
              text: "Xem Tiêu chuẩn cộng đồng",
              style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.lightBlue))
        ])),
      4 => Text.rich(TextSpan(children: [
          TextSpan(text: "Lạm dụng trẻ em\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi không cho phép hiển thị những nội dung này, ngay cả khi chúng được chia sẻ với mục đích lên án: 

• Nội dung hiển thị hình ảnh trẻ em đang khỏa thân 

• Nội dung hiển thị hoạt động tình dục liên quan đến trẻ em, định giới tính cho trẻ em hoặc gạ gẫm các hoạt động tình dục hay nội dung gợi dục từ trẻ em 

• Nội dung bày tỏ về sở thích tình dục ở trẻ em 

• Ngôn ngữ khiêu dâm hiển thị cùng hình ảnh hoặc video của trẻ em 

• Nội dung bóc lột trẻ em bằng cách hiển thị cho các bé nội dung tình dục, sắp xếp buổi gặp mặt hoặc đe dọa sẽ tung hình ảnh/cuộc trò chuyện thân mật nhạy cảm của các bé 

• Nội dung liên quan đến hành vi lạm dụng trẻ em phi tình dục 

Chúng tôi cũng sẽ báo cáo những trường hợp nghi là bóc lột tình dục trẻ em cho các cơ quan có thẩm quyền trên toàn thế giới.""",
              style: themeData.textTheme.bodyMedium),
        ])),
      5 => Text.rich(TextSpan(children: [
          TextSpan(text: "Ngược đãi động vật\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text: """Chúng tôi không cho phép: 

• Nội dung hiển thị, thừa nhận hoặc xúi giục hành vi gây hại cho động vật 

• Dàn cảnh động vật tấn công nhau 

Chúng tôi cho phép: 

• Nội dung về việc săn bắn, đánh bắt, tế lễ tôn giáo, chuẩn bị và xử lý thức ăn, tiêu diệt các giống gây hại và tự vệ""",
              style: themeData.textTheme.bodyMedium),
        ])),
      6 => Text.rich(TextSpan(children: [
          TextSpan(text: "Hoạt động tình dục\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi chỉ gỡ những nội dung vi phạm Tiêu chuẩn cộng đồng của mình, chẳng hạn như: 

• Hoạt động tình dục 

• Bán hoặc mua dâm 

• Nhũ hoa (trừ trường hợp đang cho con bú, liên quan đến sức khỏe và hành động phản đối) 

• Ảnh khỏa thân hiển thị bộ phận sinh dục """,
              style: themeData.textTheme.bodyMedium),
        ])),
      7 => Text.rich(TextSpan(children: [
          TextSpan(
              text: "Nên làm gì nếu có ai đó cần hỗ trợ\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Nếu liên hệ được với những người này, bạn có thể gợi ts hoặc tự mình gọi đường dây trợ giúp. Bạn có thể tìm thêm thông tin trong tài nguyên của chúng tôi.""",
              style: themeData.textTheme.bodyMedium),
        ])),
      8 => Text.rich(TextSpan(children: [
          TextSpan(text: "Ngôn từ gây thù ghét\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi chỉ gỡ nội dung trực tiếp công kích mọi người dựa trên một số đặc điểm được bảo vệ, chẳng hạn như: 

• Ngôn từ bạo lực hoặc xúc phạm nhân phẩm 
VD: so sánh tất cả những người thuộc một chủng tộc nào đó với côn trùng hoặc động vật.

• Lời lẽ hạ thấp, khinh miệt hoặc coi thường người khác 
VD: gợi ý rằng tất cả những người thuộc giới tính nào đó là ghê tởm.

• Từ ngữ phỉ báng 
VD: dùng các định kiến rập khuôn có hại về chủng tộc để lăng mạ ai đó.

• Lời kêu gọi bài xích hoặc cô lập
VD: nói rằng những người thuộc tôn giáo nào đó không được phép bỏ phiếu.""",
              style: themeData.textTheme.bodyMedium),
        ])),
      9 => Text.rich(TextSpan(children: [
          TextSpan(
              text: "Quảng bá hành vi sử dụng ma túy\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi chỉ gỡ nội dung vi phạm các tiêu chuẩn của mình. Chúng tôi không cho phép hiển thị nội dung chứa phát ngôn cổ xúy hoặc xúi giục việc sử dụng hay chế tạo các chất cấm/chất gây nghiện (chẳng hạn như cocain hay heroin).""",
              style: themeData.textTheme.bodyMedium),
        ])),
      12 => Text.rich(TextSpan(children: [
          TextSpan(text: "Quấy rối\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi chỉ gỡ những nội dung vi phạm Tiêu chuẩn cộng đồng của mình, chẳng hạn như: 

• Lăng mạ hoặc chế nhạo ai đó 

• Kêu gọi hành vi tự gây thương tích hoặc tự tử 

• Tấn công qua các khái niệm gợi dục mang tính xúc phạm 

• Không ngừng liên hệ với một người khi họ không hề muốn như vậy 

• Không ngừng liên hệ với nhiều người mà không thông báo trước

Các tiêu chuẩn của chúng tôi bảo vệ trẻ vị thành niên và các cá nhân nhiều hơn so với người lớn và người của công chúng.""",
              style: themeData.textTheme.bodyMedium),
        ])),
      13 => Text.rich(TextSpan(children: [
          TextSpan(text: "Bán hàng trái phép\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text: """Chúng tôi không cho phép: 

• Mua bán hay tặng tài khoản, vai trò hoặc quyền  

• Khuyến khích mọi người tương tác với nội dung sai sự thật  

• Dùng liến kết gây hiểu nhầm để chuyển mọi người từ AntiFacebook đến nơi khác""",
              style: themeData.textTheme.bodyMedium),
        ])),
      14 => Text.rich(TextSpan(children: [
          TextSpan(text: "Bạo lực\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Chúng tôi chỉ gỡ những nội dung vi phạm Tiêu chuẩn cộng đồng của mình, chẳng hạn như: 

• Đe dọa sử dụng bạo lực 
VD: nhắm mục tiêu một người và nhắc đến vũ khí cụ thể 

• Cá nhân hoặc tổ chức nguy hiểm 
VD: chủ nghĩa khủng bố hoặc một tổ chức tội phạm 

• Hình ảnh cực kỳ bạo lực 
VD: tôn vinh bạo lực hoặc tán dương sự đau khổ 

• Một loại bạo lực khác 
VD: hình ảnh hoặc nội dung khác gây khó chịu""",
              style: themeData.textTheme.bodyMedium),
        ])),
      15 => Text.rich(TextSpan(children: [
          TextSpan(text: "Chia sẻ hình ảnh riêng tư\n", style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  """Việc chia sẻ hình ảnh riêng tư có thể gây tác hại nghiêm trọng. Bằng cách báo cáo, bạn có thể góp phần ngăn chặn bớt tác hại. 

• Một người bạn chia sẻ ảnh một người gần như khỏa thân 

• Ai đó chia sẻ ảnh khỏa thân của một người bạn dưới dạng ảnh chế 

• Ai đó chia sẻ ảnh khỏa thân mà người trong ảnh không biết""",
              style: themeData.textTheme.bodyMedium),
        ])),
      _ => Text.rich(TextSpan(children: [
          TextSpan(
              text: "Nội dung này có vi phạm tiêu chuẩn cộng đồng của chúng tôi không?\n",
              style: themeData.textTheme.titleLarge),
          TextSpan(
              text:
                  "Các tiêu chuẩn của chúng tôi giải thích về những gì chúng tôi cho phép và không cho phép hiển thị trên Anti Fakebook. Với sự hỗ trợ của các chuyên gia, chúng tôi thường xuyên xem xét và cập nhật các tiêu chuẩn mình đề ra.\n",
              style: themeData.textTheme.bodyMedium)
        ]))
    };

    return Scaffold(
      appBar: AFBAppBar(
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(child: detail)),
            AFBPrimaryEButton(
                onPressed: () {},
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: const Center(child: Text("Gửi"))))
          ],
        ),
      ),
    );
  }
}
