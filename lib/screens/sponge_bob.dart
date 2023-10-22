import 'dart:math';

import 'package:flutter/material.dart';

class SpongeBobCustomPaint extends StatelessWidget {
  const SpongeBobCustomPaint({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(painter: SpongeBobPainter(), child: Container()));
  }
}

class SpongeBobPainter extends CustomPainter with SizesHelper, MathHelper {
  var eyeValue = 0.5;
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;

    initSize(size);

    canvas.drawPaint(Paint()..color = Colors.yellow.shade300);
    canvas.translate(w / 2, h / 2);

    _drawFace(canvas, w, h);
  }

  _drawFace(Canvas canvas, double w, double h) {
    canvas.save();
    canvas.translate(0, -h / 4);

    var distanceBetweenPupils = w65;
    _drawEye(canvas, distanceBetweenPupils);
    _drawEye(canvas, -distanceBetweenPupils - w10);
    _drawNose(canvas);
    _drawMouth(canvas);
    canvas.restore();
  }

  _drawMouth(Canvas canvas) {
    _drawLip(canvas);
    _drawLeftCheek(canvas);
    _drawRightCheek(canvas);
    _drawTooth(canvas);
    _drawTooth(canvas, position: -1);

    _drawChin(canvas);
    _drawChin(canvas, position: -1);
  }

  _drawChin(Canvas canvas, {double position = 1}) {
    final paint = Paint()
      ..color = const Color(0xffff7d63)
      ..strokeWidth = w3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(
        Path()
          ..moveTo(w40 * position, h160)
          ..conicTo(w40 - 30, h200, 0, h160, 0.4),
        paint);
  }

  _drawTooth(Canvas canvas, {double position = 1}) {
    canvas.drawPath(
        Path()
          ..moveTo(w30 * position, h95)
          ..lineTo(w28 * position, h115)
          ..moveTo(w28 * position, h115)
          ..lineTo(w5 * position, h115)
          ..moveTo(w5 * position, h115)
          ..lineTo(w5 * position, h100)
          ..close(),
        _outlinePaint
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round);
    canvas.drawRect(
        Rect.fromPoints(
            Offset(w27 * position, h98), Offset(w9 * position, h112)),
        Paint()..color = Colors.white);
  }

  _drawRightCheek(Canvas canvas) {
    final cheekInner = Path()
      ..moveTo(w115, h35)
      ..conicTo(w45, 10, w75, h60, 0.14);

    canvas.drawPath(
        cheekInner,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = w18
          ..color = Colors.yellow.shade300);
    _drawCheek(canvas, position: 1);
    _drawDotsOnCheek(canvas, position: 1);
  }

  _drawLeftCheek(Canvas canvas) {
    final cheekInner = Path()
      ..moveTo(-w160, h20)
      ..conicTo(w70, h20, -w80, h55, 0.1);

    canvas.drawPath(
        cheekInner,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = w14
          ..color = Colors.yellow.shade300);
    _drawCheek(canvas, position: -1);
    _drawDotsOnCheek(canvas, position: -1);
  }

  _drawDotsOnCheek(Canvas canvas, {double position = 1}) {
    final dotsOnCheekPaint = Paint()
      ..color = const Color(0xffA05729)
      ..strokeWidth = w3
      ..style = PaintingStyle.fill;

    final dotOnCheekRadius = w3;
    canvas.drawOval(
        Rect.fromCircle(
            center: Offset(w120 * position, h50), radius: dotOnCheekRadius),
        dotsOnCheekPaint);
    canvas.drawOval(
        Rect.fromCircle(
            center: Offset(w108 * position, h50), radius: dotOnCheekRadius),
        dotsOnCheekPaint);
    canvas.drawOval(
        Rect.fromCircle(
            center: Offset(w108 * position, h40), radius: dotOnCheekRadius),
        dotsOnCheekPaint);
  }

  _drawCheek(Canvas canvas, {double position = 1}) {
    final cheeksPaint = Paint()
      ..strokeWidth = w5
      ..color = const Color(0xffA05729)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(
        Path()
          ..moveTo(w70 * position, h50)
          ..cubicTo(w110 * position, -h10, w160 * position, h70,
              w110 * position, h78),
        cheeksPaint);
  }

  _drawLip(Canvas canvas) {
    final closeLip = h140;
    final openLip = h220;
    final fillupCount = (openLip - closeLip) ~/ w6;

    for (int i = fillupCount - 1; i > 1; i--) {
      canvas.drawPath(
          Path()
            ..moveTo(-w100, h55)
            ..quadraticBezierTo(w5, closeLip + (i * w6), w100, h55),
          _outlinePaint..color = const Color(0xff550015));
    }
  }

  _drawNose(Canvas canvas) {
    Path nosePathInner = Path()
      ..moveTo(w3, h15)
      ..arcToPoint(
        Offset(w7, h60),
        radius: Radius.elliptical(w25, h25),
      );
    canvas.drawPath(
        nosePathInner,
        _outlinePaint
          ..strokeWidth = w5
          ..color = Colors.yellow.shade400
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round);
    Path nosePath = Path()
      ..moveTo(-w5, h50)
      ..quadraticBezierTo(-w10, h20, w10, h15)
      ..moveTo(w10, h15)
      ..arcToPoint(
        Offset(w7, h60),
        radius: Radius.elliptical(w30, h25),
      );

    canvas.drawPath(
        nosePath,
        _outlinePaint
          ..strokeWidth = w5
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round);
  }

  _drawEye(Canvas canvas, double distanceBetweenPupils) {
    // canvas.drawPath(
    //     Path()
    //       ..moveTo(-distanceBetweenPupils, -h10)
    //       ..lineTo(w6 - distanceBetweenPupils, h50),
    //     _outlinePaint);
    // canvas.drawPath(
    //     Path()
    //       ..moveTo(-w10 - distanceBetweenPupils, -h10)
    //       ..lineTo(-w35 - distanceBetweenPupils, h50),
    //     _outlinePaint);
    // canvas.drawPath(
    //     Path()
    //       ..moveTo(w20 - distanceBetweenPupils, -h10)
    //       ..lineTo(w46 - distanceBetweenPupils, h50),
    //     _outlinePaint);
    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w50, _outlinePaint);
    canvas.drawCircle(
        Offset(-distanceBetweenPupils, 0), w46, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w24,
        _outlinePaint..strokeWidth = w3);
    canvas.drawCircle(Offset(-distanceBetweenPupils, 0), w23,
        Paint()..color = Colors.blue.shade200);
    canvas.drawCircle(
        Offset(-distanceBetweenPupils, 0), w12, Paint()..color = Colors.black);
  }

  Paint get _outlinePaint => Paint()
    ..color = const Color(0xff333333).withOpacity(0.5)
    ..strokeWidth = h12
    ..style = PaintingStyle.stroke;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

mixin SizesHelper {
  late Size _size;

  initSize(Size value) {
    _size = value;
  }

  double get w230 => _size.width * 0.639;

  double get w190 => _size.width * 0.528;

  double get w185 => _size.width * 0.514;

  double get w170 => _size.width * 0.4725;

  double get w160 => _size.width * 0.445;

  double get w155 => _size.width * 0.4306;

  double get w150 => _size.width * 0.4167;

  double get w148 => _size.width * 0.4113;

  double get w145 => _size.width * 0.403;

  double get w140 => _size.width * 0.389;

  double get w135 => _size.width * 0.375;

  double get w130 => _size.width * 0.362;

  double get w125 => _size.width * 0.3475;

  double get w120 => _size.width * 0.335;

  double get w115 => _size.width * 0.3195;

  double get w110 => _size.width * 0.306;

  double get w108 => _size.width * 0.3;

  double get w105 => _size.width * 0.292;

  double get w100 => _size.width * 0.278;

  double get w90 => _size.width * 0.25;

  double get w87 => _size.width * 0.2417;

  double get w85 => _size.width * 0.2363;

  double get w80 => _size.width * 0.223;

  double get w75 => _size.width * 0.209;

  double get w70 => _size.width * 0.194;

  double get w65 => _size.width * 0.1807;

  double get w62 => _size.width * 0.1724;

  double get w60 => _size.width * 0.167;

  double get w57 => _size.width * 0.1585;

  double get w55 => _size.width * 0.154;

  double get w50 => _size.width * 0.14;

  double get w46 => _size.width * 0.13;

  double get w45 => _size.width * 0.125;

  double get w42 => _size.width * 0.1167;

  double get w40 => _size.width * 0.112;

  double get w35 => _size.width * 0.0975;

  double get w30 => _size.width * 0.085;

  double get w28 => _size.width * 0.078;

  double get w27 => _size.width * 0.075;

  double get w25 => _size.width * 0.07;

  double get w24 => _size.width * 0.067;

  double get w23 => _size.width * 0.064;

  double get w20 => _size.width * 0.056;

  double get w18 => _size.width * 0.05;

  double get w15 => _size.width * 0.0418;

  double get w14 => _size.width * 0.0389;

  double get w13 => _size.width * 0.0363;

  double get w12 => _size.width * 0.035;

  double get w9 => _size.width * 0.025;

  double get w10 => _size.width * 0.03;

  double get w7 => _size.width * 0.0195;

  double get w6 => _size.width * 0.0167;

  double get w5 => _size.width * 0.014;

  double get w4 => _size.width * 0.0112;

  double get w3 => _size.width * 0.0085;

  double get w2_5 => _size.width * 0.00695;

  double get h330 => _size.height * 0.66;

  double get h297 => _size.height * 0.594;

  double get h290 => _size.height * 0.58;

  double get h270 => _size.height * 0.54;

  double get h265 => _size.height * 0.53;

  double get h260 => _size.height * 0.52;

  double get h255 => _size.height * 0.51;

  double get h245 => _size.height * 0.49;

  double get h240 => _size.height * 0.48;

  double get h235 => _size.height * 0.47;

  double get h230 => _size.height * 0.46;

  double get h225 => _size.height * 0.45;

  double get h220 => _size.height * 0.44;

  double get h210 => _size.height * 0.42;

  double get h200 => _size.height * 0.4;

  double get h195 => _size.height * 0.39;

  double get h190 => _size.height * 0.38;

  double get h185 => _size.height * 0.37;

  double get h180 => _size.height * 0.36;

  double get h174 => _size.height * 0.348;

  double get h170 => _size.height * 0.34;

  double get h165 => _size.height * 0.33;

  double get h160 => _size.height * 0.32;

  double get h155 => _size.height * 0.31;

  double get h150 => _size.height * 0.3;

  double get h140 => _size.height * 0.28;

  double get h130 => _size.height * 0.26;

  double get h125 => _size.height * 0.25;

  double get h120 => _size.height * 0.24;

  double get h115 => _size.height * 0.23;

  double get h112 => _size.height * 0.224;

  double get h110 => _size.height * 0.22;

  double get h100 => _size.height * 0.2;

  double get h98 => _size.height * 0.196;

  double get h95 => _size.height * 0.19;

  double get h90 => _size.height * 0.18;

  double get h87 => _size.height * 0.174;

  double get h80 => _size.height * 0.16;

  double get h78 => _size.height * 0.156;

  double get h77 => _size.height * 0.154;

  double get h75 => _size.height * 0.15;

  double get h74 => _size.height * 0.148;

  double get h70 => _size.height * 0.14;

  double get h65 => _size.height * 0.13;

  double get h60 => _size.height * 0.12;

  double get h58 => _size.height * 0.114;

  double get h57 => _size.height * 0.114;

  double get h55 => _size.height * 0.11;

  double get h52 => _size.height * 0.104;

  double get h50 => _size.height * 0.1;

  double get h45 => _size.height * 0.09;

  double get h40 => _size.height * 0.08;

  double get h35 => _size.height * 0.07;

  double get h32 => _size.height * 0.064;

  double get h30 => _size.height * 0.06;

  double get h25 => _size.height * 0.05;

  double get h20 => _size.height * 0.04;

  double get h15 => _size.height * 0.03;

  double get h12 => _size.height * 0.024;

  double get h10 => _size.height * 0.02;

  double get h7 => _size.height * 0.014;

  double get h6 => _size.height * 0.012;

  double get h4 => _size.height * 0.008;

  double get h2_5 => _size.height * 0.005;
}

mixin MathHelper {
  double computeRangeMinMax(double animationValue, double min, double max) {
    return ((max - min) * animationValue) + min;
  }

  double convertToRadian(double degree) => degree * pi / 180;
}
