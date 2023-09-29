import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NameSignupUI extends StatelessWidget {
  NameSignupUI({super.key});

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: TransparentAppBar(
        title: Text(
          "Tên",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Bạn tên gì?",
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Text("Nhập tên bạn sử dụng trong đời thực."),
            Form(
              key: (BlocProvider.of<SignupBloc>(context).state
                      as SignupStep1State)
                  .key,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: lastName,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            label: const Text("Họ"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: firstName,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            label: const Text("Tên"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        MaterialStatePropertyAll(themeData.primaryColor)),
                onPressed: () {},
                child: const Text("Tiếp")),
          ],
        ),
      ),
    ));
  }
}
