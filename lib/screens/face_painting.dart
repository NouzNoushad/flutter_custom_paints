import 'package:flutter/material.dart';

class FacePainting extends StatelessWidget {
  const FacePainting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 220, 57),
      body: SafeArea(
        child: CustomPaint(
          painter: FaceDesign(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class FaceDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    canvas.translate(w / 3, h / 3);

    var path = Path()
      ..moveTo(20, -80)
      ..quadraticBezierTo(-30, -100, -60, -50);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    canvas.drawOval(
        Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 120),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4
          ..style = PaintingStyle.fill);
    canvas.drawCircle(const Offset(0, 30), 20, Paint()..color = Colors.black);
    canvas.restore();
    canvas.save();

    canvas.translate(w / 1.5, h / 2.7);

    canvas.drawOval(
        Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 120),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 4
          ..style = PaintingStyle.fill);
    canvas.drawCircle(const Offset(0, 30), 20, Paint()..color = Colors.black);

    var path2 = Path()
      ..moveTo(60, -50)
      ..quadraticBezierTo(10, -110, -40, -70);
    canvas.drawPath(
        path2,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
    canvas.restore();
    canvas.save();

    canvas.translate(w / 2, h / 1.9);
    var path3 = Path()
      ..moveTo(-w / 3, 10)
      ..lineTo(w / 3, 10)
      ..quadraticBezierTo(20, 200, -w / 3, 10);
    canvas.drawPath(
        path3,
        Paint()
          ..color = const Color.fromARGB(255, 90, 15, 15)
          ..strokeWidth = 5
          ..style = PaintingStyle.fill);
    canvas.restore();
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
