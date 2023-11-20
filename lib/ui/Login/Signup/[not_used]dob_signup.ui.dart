// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/email_signup_ui.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:intl/intl.dart';

// class DobSignupUI extends StatelessWidget {
//   DobSignupUI({super.key});

//   final formKey = GlobalKey<FormState>();
//   final controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     controller.text = DateFormat("dd/MM/yyyy")
//         .format(BlocProvider.of<SignupBloc>(context).state.dob);
//     ThemeData themeData = Theme.of(context);
//     return SafeArea(
//         child: Scaffold(
//       appBar: TransparentAppBar(
//         title: Text(
//           "Ngày sinh",
//           style: themeData.textTheme.titleMedium,
//         ),
//         leading: IconButton(
//             onPressed: () => Navigator.maybePop(context),
//             icon: const Icon(Icons.arrow_back)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text("Ngày sinh của bạn là khi nào?",
//                 style: themeData.textTheme.headlineSmall
//                     ?.copyWith(fontWeight: FontWeight.bold)),
//             Text.rich(TextSpan(children: [
//               const TextSpan(
//                   text:
//                       "Chọn ngày sinh của bạn. Bạn luôn có thể đặt thông tin này ở chế độ riêng tư vào lúc khác. "),
//               TextSpan(
//                   text: "Tại sao tôi cần cung cấp ngày sinh của mình?",
//                   style: themeData.textTheme.bodyMedium
//                       ?.copyWith(color: themeData.primaryColor),
//                   recognizer: TapGestureRecognizer()..onTap = () {})
//             ])),
//             const SizedBox(height: 10),
//             BlocBuilder<SignupBloc, SignupState>(
//               buildWhen: (previous, current) => previous.dob != current.dob,
//               builder: (context, state) {
//                 return Form(
//                   key: formKey,
//                   child: GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                           context: context,
//                           showDragHandle: true,
//                           builder: (_) => Column(
//                                 children: [
//                                   Text("Chọn ngày sinh của bạn.",
//                                       style: themeData.textTheme.headlineSmall),
//                                   Expanded(
//                                     child: CupertinoDatePicker(
//                                         mode: CupertinoDatePickerMode.date,
//                                         initialDateTime: state.dob,
//                                         maximumDate: DateTime.now(),
//                                         minimumDate:
//                                             DateTime(DateTime.now().year - 100),
//                                         onDateTimeChanged: (dob) {
//                                           context
//                                               .read<SignupBloc>()
//                                               .add(SignupDobChange(dob: dob));
//                                           controller.text =
//                                               DateFormat("dd/MM/yyyy")
//                                                   .format(dob);
//                                         }),
//                                   ),
//                                 ],
//                               ));
//                     },
//                     child: AbsorbPointer(
//                       child: TextFormField(
//                         controller: controller,
//                         decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.all(15),
//                             label: Text(
//                                 "Ngày sinh (${DateTime.now().difference(state.dob).inDays ~/ 365} tuổi)"),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10))),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     foregroundColor: themeData.canvasColor,
//                     backgroundColor: themeData.primaryColor),
//                 onPressed: () {
//                   if (formKey.currentState?.validate() != true) return;
//                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                     return BlocProvider.value(
//                       value: BlocProvider.of<SignupBloc>(context),
//                       child: EmailSignupUI(),
//                     );
//                   }));
//                 },
//                 child: const Text("Tiếp")),
//             const Spacer(),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, "/login", (route) => false);
//                   },
//                   child: Text(
//                     "Bạn đã có tài khoản ư?",
//                     style: themeData.textTheme.bodyLarge?.copyWith(
//                         color: themeData.primaryColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
