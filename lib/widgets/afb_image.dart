import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AFBNetworkImage extends StatelessWidget {
  final double? width, height;
  final BoxFit? fit;
  final String url;

  const AFBNetworkImage(
      {Key? key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
      errorWidget: (context, url, error) => const FlutterLogo(),
      placeholder: (context, _) => Container(
          decoration:
              BoxDecoration(color: themeData.colorScheme.onInverseSurface)),
    );
  }

  AFBNetworkImage copyWith({double? width, double? height, BoxFit? fit}) {
    return AFBNetworkImage(
        url: url,
        fit: fit ?? this.fit,
        width: width ?? this.width,
        height: height ?? this.height);
  }
}
