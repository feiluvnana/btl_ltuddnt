import 'package:Anti_Fakebook/widgets/afb_image.dart';
import 'package:flutter/material.dart';

class AFBCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const AFBCircleAvatar({super.key, required this.imageUrl, this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: radius ?? 40,
        height: radius ?? 40,
        clipBehavior: Clip.hardEdge,
        decoration:
            BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black12)),
        child: AFBNetworkImage(
          url: imageUrl,
          fit: BoxFit.cover,
          width: radius ?? 40,
          height: radius ?? 40,
        ),
      ),
    );
  }
}
