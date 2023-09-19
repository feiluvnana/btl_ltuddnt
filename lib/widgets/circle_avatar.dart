import 'package:flutter/material.dart';

class CircleUserAvatar extends StatelessWidget {
  final String? imageUrl;

  const CircleUserAvatar({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        child: Image.network(
          imageUrl ?? "imageUrl",
          errorBuilder: (context, error, stackTrace) => const FlutterLogo(),
        ),
      ),
    );
  }
}
