import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum MascotState { neutral, happy, thinking, sad, excited }

class MascotWidget extends StatelessWidget {
  final MascotState state;
  final double size;
  final Color? color;

  const MascotWidget({
    super.key,
    this.state = MascotState.neutral,
    this.size = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final mascotColor = color ?? Theme.of(context).primaryColor;

    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: CustomPaint(
          size: const Size(100, 100),
          painter: MascotPainter(state: state, color: mascotColor),
        ),
      ),
    )
        .animate(key: ValueKey(state))
        // Entrance sequence
        .fadeIn(duration: 400.ms)
        .scale(duration: 400.ms, curve: Curves.easeOutBack)
        .shake(hz: 2, duration: 400.ms)
        // Idle sequence (looped)
        .then(delay: 0.ms)
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine)
        .rotate(begin: -0.05, end: 0.05, duration: 3.seconds, curve: Curves.easeInOutSine);
  }
}

class MascotPainter extends CustomPainter {
  final MascotState state;
  final Color color;

  MascotPainter({required this.state, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Body (Shield shape)
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.2);
    path.lineTo(size.width * 0.9, size.height * 0.2);
    path.lineTo(size.width * 0.9, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.9, size.width * 0.5, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.9, size.width * 0.1, size.height * 0.6);
    path.close();
    canvas.drawPath(path, paint);

    // Eyes
    switch (state) {
      case MascotState.neutral:
        canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.45), 5, strokePaint..style = PaintingStyle.fill);
        canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.45), 5, strokePaint..style = PaintingStyle.fill);
        break;
      case MascotState.happy:
      case MascotState.excited:
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.35, size.height * 0.45), width: 15, height: 15), 3.14, 3.14, false, strokePaint..style = PaintingStyle.stroke);
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.65, size.height * 0.45), width: 15, height: 15), 3.14, 3.14, false, strokePaint..style = PaintingStyle.stroke);
        break;
      case MascotState.thinking:
        canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.45), 5, strokePaint..style = PaintingStyle.fill);
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.65, size.height * 0.4), width: 20, height: 10), 0, 3.14, false, strokePaint..style = PaintingStyle.stroke);
        break;
      case MascotState.sad:
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.35, size.height * 0.5), width: 15, height: 15), 0, 3.14, false, strokePaint..style = PaintingStyle.stroke);
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.65, size.height * 0.5), width: 15, height: 15), 0, 3.14, false, strokePaint..style = PaintingStyle.stroke);
        break;
    }

    // Mouth
    strokePaint.style = PaintingStyle.stroke;
    switch (state) {
      case MascotState.happy:
      case MascotState.excited:
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.7), width: 30, height: 20), 0, 3.14, false, strokePaint);
        break;
      case MascotState.neutral:
      case MascotState.thinking:
        canvas.drawLine(Offset(size.width * 0.4, size.height * 0.75), Offset(size.width * 0.6, size.height * 0.75), strokePaint);
        break;
      case MascotState.sad:
        canvas.drawArc(Rect.fromCenter(center: Offset(size.width * 0.5, size.height * 0.8), width: 20, height: 15), 3.14, 3.14, false, strokePaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant MascotPainter oldDelegate) => oldDelegate.state != state || oldDelegate.color != color;
}
