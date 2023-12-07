// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/agreement_signup.ui.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_transparent_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SaveInfoSignupUI extends ConsumerWidget {
//   const SaveInfoSignupUI({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ThemeData themeData = Theme.of(context);
//     return Scaffold(
//       appBar: AFBTransparentAppBar(
//         title: Text(
//           "Lưu thông tin đăng nhập",
//           style: themeData.textTheme.titleMedium,
//         ),
//         leading: IconButton(
//             onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text("Lưu thông tin đăng nhập?",
//                 style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
//             const Text(
//                 "Chúng tôi sẽ lưu thông tin đăng nhập cho bạn để bạn không cần nhập vào lần sau."),
//             const SizedBox(height: 10),
//             AFBPrimaryEButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                     return const AgreementSignupUI();
//                   }));
//                 },
//                 child: const Text("Lưu")),
//             AFBSecondaryEButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                     return const AgreementSignupUI();
//                   }));
//                 },
//                 child: const Text("Lúc khác")),
//             const Spacer(),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
//                     ref.read(authenControllerProvider.notifier).updateSignupInfo(info: {});
//                   },
//                   child: Text(
//                     "Bạn đã có tài khoản ư?",
//                     style: themeData.textTheme.bodyLarge
//                         ?.copyWith(color: themeData.colorScheme.primary, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
