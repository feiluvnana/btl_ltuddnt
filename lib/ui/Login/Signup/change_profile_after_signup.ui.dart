import 'dart:io';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/signup_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileAfterSignupUI extends StatefulWidget {
  const ChangeProfileAfterSignupUI({super.key});

  @override
  State<ChangeProfileAfterSignupUI> createState() => _ChangeProfileAfterSignupUIState();
}

class _ChangeProfileAfterSignupUIState extends State<ChangeProfileAfterSignupUI> {
  File? avatar;
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TransparentAppBar(
        title: Text(
          "Thêm thông tin",
          style: themeData.textTheme.titleMedium,
        ),
        leading: IconButton(
            onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nhập thông tin của bạn",
                style: themeData.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const Text("Tên của bạn:"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    label: const Text("Tên"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const Text("Ảnh của bạn:"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputDecorator(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    label: const Text("Ảnh"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      children: [
                        Expanded(
                            child: Image.file(
                          avatar ?? File(""),
                          errorBuilder: (_, __, ___) => Container(),
                        )),
                        ElevatedButton(
                            onPressed: () {
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) async {
                                if (value == null) return;
                                var file = File(value.path);
                                setState(() {
                                  avatar = file;
                                });
                              });
                            },
                            child: const Text("Thêm hình ảnh"))
                      ],
                    )),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.canvasColor,
                    backgroundColor: themeData.primaryColor),
                onPressed: () => context.read<SignupBloc>().add(SignupChangeProfileAfter(
                    username.text,
                    avatar,
                    () => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false)
                        .whenComplete(
                            () => context.read<NewsfeedBloc>().add(const NewsfeedInit())))),
                child: const Text("Tiếp")),
          ],
        ),
      ),
    ));
  }
}
