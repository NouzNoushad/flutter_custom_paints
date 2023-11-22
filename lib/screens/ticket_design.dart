import 'package:flutter/material.dart';

class TicketDesign extends StatelessWidget {
  const TicketDesign({super.key});

  static List<Color> colors = [
    Colors.orange,
    Colors.teal,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          'Tickets',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 170, 217, 241),
        child: ListView.separated(
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Stack(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                          color: colors[index],
                          height: double.infinity,
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                'Movie #${index + 1}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ticket Title #${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Row(children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Material(
                                              elevation: 2,
                                              child: Container(
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Expanded(
                                              child: Image.asset(
                                                  'assets/bar_code.jpg')),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: Text(
                                              '00 month 2023 00:00',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Icon(Icons.location_on_outlined),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: Text(
                                              'Destination venue',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton.icon(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: const StadiumBorder(
                                                    side: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue))),
                                            icon:
                                                const Icon(Icons.check_circle),
                                            label: Text(
                                              'Buy Tickets'.toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ))
                                      ],
                                    ))
                                  ]),
                                ),
                              ]),
                        ),
                      ),
                    ]),
                    CustomPaint(
                        painter: TicketPaint(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                        )),
                    // CustomPaint(
                    //     painter: DottedPath(),
                    //     child: SizedBox(
                    //       height: MediaQuery.of(context).size.height * 0.25,
                    //       width: double.infinity,
                    //     )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
            itemCount: colors.length),
      ),
    );
  }
}

class DottedPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startX = 10;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    while (startX < size.width - 10) {
      canvas.drawLine(Offset(startX, size.height / 1.5),
          Offset(startX + dashWidth, size.height / 1.5), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TicketPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, h / 2), radius: 18),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w, h / 2), radius: 18),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w / 5, h), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w / 5, 0), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, h), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(0, 0), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = const Color.fromARGB(255, 170, 217, 241),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
