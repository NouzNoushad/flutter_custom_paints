import 'dart:math';

import 'package:flutter/material.dart';

class PacMan extends StatelessWidget {
  const PacMan({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PacManPainter(), child: Container());
  }
}

class PacManPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    Paint paint = Paint()..color = Colors.yellow;
    Rect rect =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: 50, height: 50);

    double startAngle = 0.4;
    double sweepAngle = 2 * pi - 0.8;
    bool useCenter = true;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
