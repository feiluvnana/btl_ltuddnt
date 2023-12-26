import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AFBNetworkImage extends StatelessWidget {
  final double? width, height;
  final BoxFit? fit;
  final String url;
  final bool reduceQuality;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  const AFBNetworkImage(
      {super.key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      required this.url,
      this.reduceQuality = false,
      this.errorWidget});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      memCacheHeight: reduceQuality ? height?.toInt() : null,
      memCacheWidth: reduceQuality ? width?.toInt() : null,
      errorWidget: errorWidget ?? (context, url, error) => const Placeholder(),
      placeholder: (context, _) =>
          Container(decoration: BoxDecoration(color: themeData.colorScheme.onInverseSurface)),
    );
  }

  AFBNetworkImage copyWith({double? width, double? height, BoxFit? fit}) {
    return AFBNetworkImage(
        url: url,
        fit: fit ?? this.fit,
        width: width ?? this.width,
        height: height ?? this.height,
        reduceQuality: reduceQuality);
  }
}
