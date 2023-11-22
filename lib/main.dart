import 'package:custom_paint_exp/screens/custom_paint_exp.dart';
import 'package:custom_paint_exp/screens/face_painting.dart';
import 'package:custom_paint_exp/screens/pac_man.dart';
import 'package:custom_paint_exp/screens/progress_button.dart';
import 'package:custom_paint_exp/screens/render_gap.dart';
import 'package:custom_paint_exp/screens/shimmer_effect.dart';
import 'package:custom_paint_exp/screens/sponge_bob.dart';
import 'package:custom_paint_exp/screens/ticket_design.dart';
import 'package:flutter/material.dart';

import 'screens/face_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const TicketDesign(),
    );
  }
}
