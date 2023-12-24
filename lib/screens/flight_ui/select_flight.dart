import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class SelectFlightScreen extends StatelessWidget {
  const SelectFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 59, 96, 1),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: const Color.fromRGBO(35, 59, 96, 1),
                    child: Image.asset('assets/map_img.png'),
                  ),
                ),
                const SizedBox(
                  height: 55,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Text(
                        'Select Flight',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                    ]),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 40,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        color: Colors.transparent,
                        child: CustomPaint(
                          painter: DottedArc(),
                        ),
                      ),
                      const Positioned(
                        top: 14,
                        left: 85,
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.flight,
                              color: Colors.white,
                            )),
                      ),
                      Positioned(
                        bottom: -30,
                        child: Container(
                          height: 100,
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          color: Colors.transparent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 1.5, color: Colors.grey.shade300),
                        )),
                        child: const Row(children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.sort,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.menu,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '7 Flight available',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(35, 59, 96, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ClipPath(
                            clipper: SideCutClipper(),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(35, 59, 96, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Sydney',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Depart',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '8:30 AM',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Sky'.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'London',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'Depart',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  'EK008',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                              child: CustomPaint(
                                            painter: DottedLine(),
                                          )),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor: Colors.white,
                                              ),
                                              RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons.flight,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 5,
                                                backgroundColor: Colors.white,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$80000/-',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'View Details',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: 7)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class SideCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    var radius = 12;
    var position = (h - 70) + (radius / 2);
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(w, 0.0);
    path.lineTo(w, position - radius);
    path.arcToPoint(
      Offset(w, position),
      clockwise: false,
      radius: const Radius.circular(1),
    );

    path.lineTo(w, h);
    path.lineTo(0.0, h);
    path.lineTo(0, position);
    path.arcToPoint(
      Offset(0, position - radius),
      clockwise: false,
      radius: const Radius.circular(1),
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DottedLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 3;
    double startX = 10;
    final paint = Paint()
      ..color = const Color.fromARGB(255, 170, 217, 241)
      ..strokeWidth = 0.8;

    while (startX < size.width - 10) {
      canvas.drawCircle(Offset(startX, size.height / 2), 1.5, paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var sp = Offset(10, h - 20);
    var cp1 = Offset(w / 5, h / 15);
    var cp2 = Offset(4 * w / 5, h / 15);
    var ep = Offset(w - 10, h - 20);

    var path = Path();
    path.moveTo(sp.dx, sp.dy);
    path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, ep.dx, ep.dy);
    var curvePath = dashPath(path, dashArray: CircularIntervalList([4, 5]));
    canvas.drawPath(
        curvePath,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
