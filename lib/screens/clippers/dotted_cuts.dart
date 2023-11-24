import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class TicketClipperDesign extends StatelessWidget {
  const TicketClipperDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: FlutterTicketBuilder(
        height: 200,
        width: 200,
        radius: 80,
        position: 100,
        dotColor: Colors.yellow,
        edge: Edge.horizontal,
      ),
    );
  }
}

class FlutterTicketBuilder extends StatelessWidget {
  const FlutterTicketBuilder(
      {super.key,
      required this.height,
      required this.width,
      required this.dotColor,
      this.radius = 15,
      this.position = 20,
      this.edge = Edge.horizontal,
      this.backgroundColor = Colors.white});

  final double height;
  final double width;
  final double radius;
  final double position;
  final Edge edge;
  final Color backgroundColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        ClipPath(
          clipper: TicketRoundedEdgeClipper(
              edge: edge, radius: radius, position: position),
          child: Container(
            height: height,
            width: width,
            color: backgroundColor,
          ),
        ),
      ],
    ));
  }
}

class DashedLinePainter extends CustomPainter {
  final Axis axis;
  final double dashHeight, dashWidth, dashSpace, strokeWidth;
  final Color dashColor;

  const DashedLinePainter(
      {required this.axis,
      required this.dashHeight,
      required this.dashWidth,
      required this.dashSpace,
      required this.strokeWidth,
      required this.dashColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (axis == Axis.vertical) {
      double startY = 0;
      final paint = Paint()
        ..color = dashColor
        ..strokeWidth = strokeWidth;
      while (startY < size.height) {
        canvas.drawLine(
            Offset(0, startY), Offset(0, startY + dashHeight), paint);
        startY += dashHeight + dashSpace;
      }
    } else {
      double startX = 0;
      final paint = Paint()
        ..color = dashColor
        ..strokeWidth = strokeWidth;
      while (startX < size.width) {
        canvas.drawLine(
            Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedLine extends CustomPainter {
  DottedLine(
      {this.lineSpace = 0,
      // this.lineWidth = 10,
      required this.color,
      this.thickness = 1,
      this.position = 20,
      this.dotRadius = 10,
      this.radius = 15,
      this.edge = Edge.horizontal});
  // final double lineWidth;
  final double lineSpace;
  final Color color;
  final double thickness;
  final double position;
  final double dotRadius;
  final double radius;
  final Edge edge;

  @override
  void paint(Canvas canvas, Size size) {
    double start = radius / 1.8;
    var h = size.height;
    var w = size.width;
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    if (edge == Edge.vertical || edge == Edge.top || edge == Edge.bottom) {
      while (start < h - radius / 1.8) {
        canvas.drawCircle(Offset(position, start), dotRadius, paint);
        // canvas.drawLine(Offset(0, start), Offset(0, start + lineWidth), paint);
        start += lineSpace * dotRadius + lineSpace;
      }
    }
    if (edge == Edge.horizontal || edge == Edge.left || edge == Edge.right) {
      start = radius / 1.8;
      while (start < w - radius / 1.8) {
        canvas.drawCircle(Offset(start, position), dotRadius, paint);
        // canvas.drawLine(Offset(start, position),
        //     Offset(start + lineWidth, position), paint);
        start += lineSpace * dotRadius + lineSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// My clipper
enum Edge { vertical, horizontal, top, bottom, left, right, all }

class TicketRoundedEdgeClipper extends CustomClipper<Path> {
  TicketRoundedEdgeClipper({
    this.edge = Edge.bottom,
    this.position = 20,
    this.radius = 15,
  });

  double position;
  final double radius;
  final Edge edge;

  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    position = position + (radius / 2);
    final path = Path();

    // Top or Vertical or All
    path.moveTo(0, 0);
    path.lineTo(position - radius, 0.0);
    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      path.arcToPoint(
        Offset(position, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Right or Horizontal or All
    path.lineTo(w, 0.0);
    path.lineTo(w, position - radius);
    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      path.arcToPoint(
        Offset(w, position),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Bottom or Vertical or All
    path.lineTo(w, h);
    path.lineTo(position, h);
    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      path.arcToPoint(
        Offset(position - radius, h),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }

    // Left or Horizontal or All
    path.lineTo(0.0, h);
    path.lineTo(0, position);
    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      path.arcToPoint(
        Offset(0, position - radius),
        clockwise: false,
        radius: const Radius.circular(1),
      );
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TicketPassClipper extends CustomClipper<Path> {
  TicketPassClipper({this.position, this.holeRadius = 16});

  double? position;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    position ??= size.width - 16;
    if (position! > size.width) {
      throw Exception('position is greater than width.');
    }
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(position! - holeRadius, 0.0)
      ..arcToPoint(
        Offset(position!, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(position!, size.height)
      ..arcToPoint(
        Offset(position! - holeRadius, size.height),
        clockwise: false,
        radius: const Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}


// Got from Stack over flow just for testing and learning purpose
// class Ticket extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.orange
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//     Path path = Path();
//     //top
//     path.moveTo(50, 0);
//     path.lineTo(50, 150);
//     path.arcToPoint(const Offset(70, 170), radius: const Radius.circular(20));
//     path.lineTo(300, 170);
//     path.arcToPoint(const Offset(320, 150), radius: const Radius.circular(20));
//     path.lineTo(320, 0);

//     //bottom
//     path.moveTo(70, 170);
//     path.lineTo(300, 190);
//     path.arcToPoint(const Offset(320, 210),
//         radius: const Radius.circular(20), clockwise: false);
//     path.lineTo(310, 290);
//     path.arcToPoint(const Offset(290, 300), radius: const Radius.circular(20));
//     path.lineTo(60, 280);
//     path.arcToPoint(const Offset(40, 260), radius: const Radius.circular(20));
//     path.lineTo(50, 190);
//     path.arcToPoint(const Offset(70, 170),
//         radius: const Radius.circular(20), clockwise: false);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(Ticket oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(Ticket oldDelegate) => false;
// }
