import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RoundedClipperDesign extends StatelessWidget {
  const RoundedClipperDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipPath(
          clipper: RoundedPointsClipper(edge: Edge.horizontal, points: 50),
          child: Container(
            height: 200,
            width: 200,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

// My Custom Clipper
enum Edge { vertical, horizontal, top, bottom, left, right, all }

class RoundedPointsClipper extends CustomClipper<Path> {
  RoundedPointsClipper({
    this.edge = Edge.bottom,
    this.points = 20,
    this.depth = 10,
  });

  final int points;
  final double depth;
  final Edge edge;

  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    Path path = Path();

    // Left or Horizontal
    path.moveTo(0, 0);
    double x = 0;
    double y = 0;
    double c = w - depth;
    double i = h / points;

    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      while (y < h) {
        path.quadraticBezierTo(depth, y + i / 2, 0, y + i);
        y += i;
      }
    }

    // Bottom or Vertical
    path.lineTo(0, h);
    x = 0;
    y = h;
    c = h - depth;
    i = w / points;

    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      while (x < w) {
        path.quadraticBezierTo(x + i / 2, c, x + i, y);
        x += i;
      }
    }

    // Right or Horizontal
    path.lineTo(w, h);
    x = w;
    y = h;
    c = w - depth;
    i = h / points;

    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      while (y > 0) {
        path.quadraticBezierTo(c, y - i / 2, w, y - i);
        y -= i;
      }
    }

    // Top or Vertical
    path.lineTo(w, 0);
    x = w;
    y = 0;
    c = h - depth;
    i = w / points;

    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      while (x > 0) {
        path.quadraticBezierTo(x - i / 2, depth, x - i, 0);
        x -= i;
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MultipleRoundedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos),
          radius: const Radius.circular(5));
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MultipleRoundedPointsClipper extends CustomClipper<Path> {
  final double heightOfPoint;
  final int numberOfPoints;
  final Sides side;

  MultipleRoundedPointsClipper(this.side,
      {this.heightOfPoint = 12, this.numberOfPoints = 16}); // final Sides side;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    double x = 0;
    double y = size.height;
    double yControlPoint = size.height - heightOfPoint;
    double increment = size.width / numberOfPoints;

    if (side == Sides.bottom || side == Sides.vertical) {
      while (x < size.width) {
        path.quadraticBezierTo(
            x + increment / 2, yControlPoint, x + increment, y);
        x += increment;
      }
    }

    path.lineTo(size.width, 0.0);

    if (side == Sides.vertical) {
      while (x > 0) {
        path.quadraticBezierTo(
            x - increment / 2, heightOfPoint, x - increment, 0);
        x -= increment;
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
