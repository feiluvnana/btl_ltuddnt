import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReactionDisplay extends StatelessWidget {
  final int kudos, dissapointed;
  const ReactionDisplay({super.key, required this.kudos, required this.dissapointed});

  @override
  Widget build(BuildContext context) {
    double kvsd = -1;
    if (dissapointed != 0) {
      kvsd = kudos / dissapointed;
    } else if (kudos != 0) {
      kvsd = 0;
    }
    return SizedBox(
      width: switch (kvsd) { <= 9 && >= 1 / 9 => 36, -1 => 0, _ => 20 },
      height: 20,
      child: Stack(
        children: [
          if (kvsd >= 0 && kvsd <= 9)
            Positioned(
              left: 0,
              child: SvgPicture.asset("assets/emojis/haha.svg", width: 20, height: 20),
            ),
          if (kvsd >= 1 / 9)
            Positioned(
              left: kvsd <= 9 ? 16 : 0,
              child: SvgPicture.asset("assets/emojis/sad.svg", width: 20, height: 20),
            ),
        ],
      ),
    );
  }
}
