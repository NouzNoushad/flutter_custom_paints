import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintScreen extends StatefulWidget {
  const CustomPaintScreen({super.key});

  @override
  State<CustomPaintScreen> createState() => _CustomPaintScreenState();
}

class _CustomPaintScreenState extends State<CustomPaintScreen>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> angleTween;
  late Animation<double> radiusTween;

  @override
  void initState() {
    controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    controller2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    angleTween = Tween(begin: -pi, end: pi).animate(controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    radiusTween = Tween(begin: 0.0, end: 800.0).animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller1.forward();
    controller2.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
          animation: angleTween,
          builder: (context, child) {
            return Center(
              child: CustomPaint(
                  painter: ShapePainter(
                    radius: radiusTween.value,
                    radians: angleTween.value,
                  ),
                  child: const SizedBox()),
            );
          }),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double radius;
  final double radians;

  ShapePainter({
    required this.radians,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    Paint paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // ------ draw line

    // var p1 = Offset(0, h / 2);
    // var p2 = Offset(w, h / 2);
    // canvas.drawLine(p1, p2, paint);

    // ------ draw circle 1

    // var c = Offset(w / 2, h / 2);
    // double radius = w / 3;
    // canvas.drawCircle(c, radius, paint);

    // ------ draw circle 2

    // Path path = Path();
    // Rect oval = Rect.fromCircle(center: Offset(w / 2, h / 2), radius: w / 4);
    // path.addOval(oval);
    // canvas.drawPath(path, paint);

    // ------ polygon

    Path path = Path();

    var side = 4;
    // var radius = w / 3;
    // var radians = pi / 4;

    var angle = pi * 2 / side;
    var center = Offset(w / 2, h / 2);
    var startPoint = Offset(radius * cos(radians), radius * sin(radians));
    // print('///////////// start: $startPoint angle: $angle, radians: $radians');

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 0; i < side; i++) {
      double x = radius * cos(radians + angle * i) + center.dx;
      double y = radius * sin(radians + angle * i) + center.dy;
      // print('//////////////// $x, /////////////////// $y');
      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
