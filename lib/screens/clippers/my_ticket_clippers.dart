import 'package:flutter/material.dart';

class MyTicketClippers extends StatelessWidget {
  const MyTicketClippers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ClipPath(
        clipper:
            TicketRoundedEdgeClipper(edge: Edge.all, position: 100, radius: 50),
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

class RoundedEdgeClipper extends CustomClipper<Path> {
  RoundedEdgeClipper({
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
