// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/helpers/validators.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/ui/Login/Signup/dob_signup_ui.dart';
// import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NameSignupUI extends StatelessWidget {
//   NameSignupUI({super.key});

//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     return SafeArea(
//         child: Scaffold(
//       appBar: TransparentAppBar(
//         title: Text(
//           "Tên",
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
//             Text("Bạn tên gì?",
//                 style: themeData.textTheme.headlineSmall
//                     ?.copyWith(fontWeight: FontWeight.bold)),
//             const Text("Nhập tên bạn sử dụng trong đời thực."),
//             BlocBuilder<SignupBloc, SignupState>(
//               buildWhen: (previous, current) =>
//                   previous.firstName != current.firstName ||
//                   previous.lastName != current.lastName,
//               builder: (context, state) {
//                 return Form(
//                   key: formKey,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             initialValue: state.lastName,
//                             validator: Validators.signupLastnameValidator,
//                             onChanged: (lastName) {
//                               context
//                                   .read<SignupBloc>()
//                                   .add(SignupNameChange(lastName: lastName));
//                             },
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(15),
//                                 label: const Text("Họ"),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10))),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             initialValue: state.firstName,
//                             validator: Validators.signupFirstnameValidator,
//                             onChanged: (firstName) {
//                               context
//                                   .read<SignupBloc>()
//                                   .add(SignupNameChange(firstName: firstName));
//                             },
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(15),
//                                 label: const Text("Tên"),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10))),
//                           ),
//                         ),
//                       ),
//                     ],
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
//                       child: DobSignupUI(),
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
