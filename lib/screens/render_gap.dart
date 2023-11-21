import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderGapScreen extends StatelessWidget {
  const RenderGapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
              const Gap(50),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ],
          ),
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
              const Gap(50),
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Gap extends LeafRenderObjectWidget {
  final double mainAxisExtend;
  const Gap(this.mainAxisExtend, {super.key})
      : assert(mainAxisExtend >= 0 && mainAxisExtend < double.infinity);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGap(mainAxisExtend: mainAxisExtend);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderGap renderObject) {
    renderObject.mainAxisExtend = mainAxisExtend;
  }
}

class RenderGap extends RenderBox {
  double _mainAxisExtend;
  RenderGap({
    double? mainAxisExtend,
  }) : _mainAxisExtend = mainAxisExtend!;
  double get mainAxisExtend => _mainAxisExtend;
  set mainAxisExtend(double value) {
    if (_mainAxisExtend != value) {
      _mainAxisExtend = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final RenderObject flex = parent!;
    if (flex is RenderFlex) {
      if (flex.direction == Axis.horizontal) {
        size = constraints.constrain(Size(mainAxisExtend, 0));
      } else {
        size = constraints.constrain(Size(0, mainAxisExtend));
      }
    } else {
      throw FlutterError(
        'A Gap widget must be placed directly inside a Flex widget',
      );
    }
  }
}
