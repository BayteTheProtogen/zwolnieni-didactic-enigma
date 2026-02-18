import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum MascotState { neutral, happy, thinking, sad, excited }

class MascotWidget extends StatelessWidget {
  final MascotState state;
  final double size;

  const MascotWidget({
    super.key,
    this.state = MascotState.neutral,
    this.size = 100,
  });

  String get _emoticon {
    switch (state) {
      case MascotState.neutral:
        return ':)';
      case MascotState.happy:
        return '(^‿^)';
      case MascotState.thinking:
        return '(•ิ_•ิ)?';
      case MascotState.sad:
        return '(╯_╰)';
      case MascotState.excited:
        return '\\(^ヮ^)/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 1.5,
      height: size,
      alignment: Alignment.center,
      child: Text(
        _emoticon,
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      )
          .animate(key: ValueKey(state))
          .fadeIn()
          .scale(duration: 300.ms, curve: Curves.easeOutBack)
          .shimmer(delay: 2.seconds, duration: 1.seconds)
          .shake(hz: 2)
          .then()
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine)
          .rotate(begin: -0.05, end: 0.05, duration: 3.seconds, curve: Curves.easeInOutSine),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
     .scale(begin: const Offset(1, 1), end: const Offset(1.05, 0.95), duration: 1.5.seconds, curve: Curves.easeInOut);
  }
}
