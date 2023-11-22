import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularUserAvatar extends StatelessWidget {
  final String imageUrl;
  final double? radius;

  const CircularUserAvatar({super.key, required this.imageUrl, this.radius});

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
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const FlutterLogo(),
        ),
      ),
    );
  }
}
