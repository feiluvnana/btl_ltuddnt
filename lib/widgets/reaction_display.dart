import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReactionDisplay extends StatelessWidget {
  const ReactionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20 + 32,
      height: 20,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset("assets/emojis/like.svg",
                width: 20, height: 20),
          ),
          Positioned(
            left: 16,
            child: SvgPicture.asset("assets/emojis/love.svg",
                width: 20, height: 20),
          ),
          Positioned(
            left: 32,
            child: SvgPicture.asset("assets/emojis/haha.svg",
                width: 20, height: 20),
          ),
        ],
      ),
    );
  }
}
