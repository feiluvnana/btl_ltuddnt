import 'package:flutter/material.dart';

class CircleUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const CircleUserAvatar({super.key, this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        foregroundImage: NetworkImage(imageUrl ?? "imageUrl"),
        radius: radius ?? 20,
      ),
    );
  }
}
