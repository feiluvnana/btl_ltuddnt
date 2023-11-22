import 'dart:io';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/authen_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/blocs/newsfeed_bloc.dart';
import 'package:btl_lap_trinh_ung_dung_da_nen_tang/widgets/afb_button.dart';
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
  bool isLocked = false;
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
                            child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Image.file(
                            avatar ?? File(""),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(),
                          ),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AFBPrimaryEButton(
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
                                child: const Text("Thêm hình ảnh")),
                            AFBDangerEButton(
                                onPressed: () {
                                  setState(() {
                                    avatar = null;
                                  });
                                },
                                child: const Text("Xóa hình ảnh")),
                          ],
                        )
                      ],
                    )),
              ),
            ),
            AFBPrimaryEButton(
                onPressed: isLocked
                    ? null
                    : () {
                        setState(() {
                          isLocked = true;
                        });
                        context.read<AuthenBloc>().add(AuthenChangeProfileAfter(
                            username.text,
                            avatar,
                            () => Navigator.pushNamedAndRemoveUntil(
                                    context, "/home", (route) => false)
                                .whenComplete(
                                    () => context.read<NewsfeedBloc>().add(const NewsfeedInit())),
                            () => setState(() {
                                  isLocked = false;
                                })));
                      },
                child: const Text("Tiếp")),
          ],
        ),
      ),
    ));
  }
}
