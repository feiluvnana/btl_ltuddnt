import 'package:flutter/material.dart';

/// A widget that displays a skeleton loader effect.
class SkeletonWrapper extends StatelessWidget {
  final Widget child;
  final bool enabled;

  /// Create a skeleton loader effect for [child]. The effect will display only if the [enable] is true, which is the default value.
  const SkeletonWrapper({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return enabled
        ? ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [child, _Skeleton()],
            ),
          )
        : child;
  }
}

class _Skeleton extends StatefulWidget {
  @override
  State<_Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<_Skeleton> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Color> _colors = const [
    Color(0xFFDFDFE8),
    Color(0xFFEAEAEA),
    Color(0xFFDFDFE8)
  ];

  @override
  void initState() {
    _controller = AnimationController(
        value: 0, duration: const Duration(milliseconds: 1000), vsync: this)
      ..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: _colors,
                      stops: const [0, 0.25, 0.5],
                      begin: const Alignment(-1.0, -0.25),
                      end: const Alignment(1.0, 0.25),
                      tileMode: TileMode.clamp,
                      transform: _SlidingGradientTransform(
                          slidePercent: _controller.value))));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
        bounds.width * (slidePercent - 0.25), 0.0, 0.0);
  }
}
