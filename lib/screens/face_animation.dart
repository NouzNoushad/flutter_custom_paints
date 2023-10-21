import 'package:flutter/material.dart';

class FaceAnimation extends StatelessWidget {
  const FaceAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: CustomPaint(
            painter: FacePaint(),
            child: Container(
                // color: Colors.blue,
                ),
          ),
        ),
      ),
    );
  }
}

class FacePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    canvas.translate(w / 2, h / 2);

    _drawHead(canvas, w, h);
    _drawLeftEye(canvas, w, h);
    _drawRightEye(canvas, w, h);
    _drawNose(canvas, w, h);
    _drawMouth(canvas, w, h);
  }

  _drawMouth(Canvas canvas, double w, double h) {
    canvas.save();
    canvas.translate(0, 10);
    Path mouthPath = Path()
      ..moveTo(20, 30)
      ..lineTo(30, 40)
      ..arcToPoint(
        const Offset(-20, 50),
        radius: const Radius.circular(200),
        largeArc: false,
        clockwise: false,
      )
      ..moveTo(25, 42)
      ..lineTo(15, 52);

    canvas.drawPath(mouthPath, _outlinePaint);
    canvas.restore();
  }

  _drawNose(Canvas canvas, double w, double h) {
    canvas.save();
    canvas.translate(20, 10);
    Path nosePath = Path()
      ..moveTo(-20, -20)
      ..lineTo(0, 0)
      ..lineTo(-20, 20);
    canvas.drawPath(nosePath, _outlinePaint);

    Path noseShadowPath = Path()
      ..moveTo(-20, -20)
      ..lineTo(10, 0)
      ..lineTo(-20, 20);
    canvas.drawPath(
        noseShadowPath,
        Paint()
          ..color = Colors.grey.withOpacity(0.17)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round);
    canvas.restore();
  }

  _drawRightEye(Canvas canvas, double w, double h) {
    Path eyeBrows = Path()
      ..moveTo(w / 3, -30)
      ..lineTo(w / 5, -25);

    canvas.drawPath(eyeBrows, _outlinePaint);

    Path eye = Path()
      ..moveTo(80, 5)
      ..addOval(Rect.fromCircle(center: const Offset(80, 5), radius: 25))
      ..close();
    canvas.drawPath(eye, _outlinePaint);

    canvas.drawCircle(const Offset(80, 5), 2, _outlinePaint);

    Path eyeSclera = Path()
      ..moveTo(w / 3, -8)
      ..lineTo(w / 5.5, 0)
      ..moveTo(w / 3, 16)
      ..lineTo(w / 5.5, 10)
      ..close();
    canvas.drawPath(eyeSclera, _outlinePaint);
  }

  _drawLeftEye(Canvas canvas, double w, double h) {
    Path eyeBrows = Path()
      ..moveTo(-w / 3, -30)
      ..lineTo(-w / 5, -25);

    canvas.drawPath(eyeBrows, _outlinePaint);

    Path eye = Path()
      ..moveTo(-80, 5)
      ..addOval(Rect.fromCircle(center: const Offset(-80, 5), radius: 25))
      ..close();
    canvas.drawPath(eye, _outlinePaint);

    canvas.drawCircle(const Offset(-80, 5), 2, _outlinePaint);

    Path eyeSclera = Path()
      ..moveTo(-w / 3, -8)
      ..lineTo(-w / 5.5, 0)
      ..moveTo(-w / 3, 16)
      ..lineTo(-w / 5.5, 10)
      ..close();
    canvas.drawPath(eyeSclera, _outlinePaint);
  }

  _drawHead(Canvas canvas, double w, double h) {
    var faceHeight = w * 0.7;
    canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: w, height: faceHeight),
        _outlinePaint);
    canvas.save();
    canvas.translate(-40, 20);
    for (int i = 0; i < 3; i++) {
      var x = 30 * i.toDouble();
      Path hairStrandPath = Path()
        ..moveTo(x, -faceHeight + 90)
        ..arcToPoint(Offset(x, -faceHeight / 2 + 4),
            radius: const Radius.circular(0.09));
      canvas.drawPath(hairStrandPath, _outlinePaint);
    }
    canvas.restore();
  }

  Paint get _outlinePaint {
    return Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
