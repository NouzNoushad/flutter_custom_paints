import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({super.key});

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  double percentageValue = 0.0;
  double newPercentage = 0.0;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              percentageValue =
                  lerpDouble(percentageValue, newPercentage, controller.value)!;
            });
          });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: ButtonPainter(
            borderColor: Colors.yellow,
            progressColor: Colors.purple,
            percentage: percentageValue,
            width: 10,
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                percentageValue = newPercentage;
                newPercentage += 10;
                if (newPercentage > 100) {
                  percentageValue = 0;
                  newPercentage = 0;
                }
                controller.forward(from: 0.0);
              });
            },
            style: TextButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: Colors.white),
            child: const Text(
              'Progress',
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPainter extends CustomPainter {
  final Color borderColor;
  final Color progressColor;
  final double percentage;
  final double width;

  ButtonPainter(
      {required this.borderColor,
      required this.percentage,
      required this.progressColor,
      required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = borderColor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint complete = Paint()
      ..color = progressColor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var c = Offset(size.width / 2, size.height / 2);
    var radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(c, radius, line);

    Rect rect = Rect.fromCircle(center: c, radius: radius);
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * percentage / 100;
    bool useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, complete);

    var r = 40.0;
    Rect rec = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(c, r, line);
    canvas.drawArc(rec, startAngle, sweepAngle, useCenter, complete);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
