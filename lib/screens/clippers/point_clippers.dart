import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class PointyClipperDesign extends StatelessWidget {
  const PointyClipperDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ClipPath(
        clipper:
            PointedEdgeClipper(edge: Edge.horizontal, points: 40, depth: 20),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
      )),
    );
  }
}

// My Custom Clipper
enum Edge { vertical, horizontal, top, bottom, left, right, all }

class PointedEdgeClipper extends CustomClipper<Path> {
  PointedEdgeClipper({
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
    double i = h / points;

    if (edge == Edge.left || edge == Edge.horizontal || edge == Edge.all) {
      while (y < h) {
        y += i;
        x = (x == 0) ? depth : 0;
        path.lineTo(x, y);
      }
    }

    // Bottom or Vertical
    path.lineTo(0, h);
    x = 0;
    y = h;
    i = w / points;

    if (edge == Edge.bottom || edge == Edge.vertical || edge == Edge.all) {
      while (x < w) {
        x += i;
        y = (y == h) ? h - depth : h;
        path.lineTo(x, y);
      }
    }

    // Right or Horizontal
    path.lineTo(w, h);
    x = w;
    y = h;
    i = h / points;

    if (edge == Edge.right || edge == Edge.horizontal || edge == Edge.all) {
      while (y > 0) {
        y -= i;
        x = (x == w) ? w - depth : w;
        path.lineTo(x, y);
      }
    }

    // Top or Vertical
    path.lineTo(w, 0);
    x = w;
    y = 0;
    i = w / points;

    if (edge == Edge.top || edge == Edge.vertical || edge == Edge.all) {
      while (x > 0) {
        x -= i;
        y = (y == 0) ? depth : 0;
        path.lineTo(x, y);
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

class MultiplePointedEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height ? size.height - 30 : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MultiplePointsClipper extends CustomClipper<Path> {
  final double heightOfPoint;
  final int numberOfPoints;
  final Sides side;

  MultiplePointsClipper(this.side,
      {this.heightOfPoint = 12, this.numberOfPoints = 16});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 0.0;
    double y = size.height;
    double increment = size.width / numberOfPoints / 2;

    if (side == Sides.bottom || side == Sides.vertical) {
      while (x < size.width) {
        x += increment;
        y = (y == size.height) ? size.height - heightOfPoint : size.height;
        path.lineTo(x, y);
      }
    }
    path.lineTo(size.width, 0.0);

    x = size.width;
    y = 0.0;
    if (side == Sides.vertical) {
      while (x > 0) {
        x -= increment;
        y = (y == 0) ? 0 + heightOfPoint : 0;
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => oldClipper != this;
}
