import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/shared/widgets/bubble_draw_triangle.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
    this.direction = BubbleDirection.above,
    this.color = const Color(0xBFFFFFFF),
    this.triangleSize = 60,
  });

  final Widget child;
  final EdgeInsets padding;
  final BubbleDirection direction;
  final Color color;
  final double triangleSize;

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case BubbleDirection.above:
        return Column(
          children: [
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color,
              ),
              child: child,
            ),
            CustomPaint(
              size: Size(triangleSize, triangleSize / 2),
              painter: BubbleDrawTriangle(
                color: color,
                direction: direction,
              ),
            ),
          ],
        );
      case BubbleDirection.atRight:
        return Row(
          children: [
            CustomPaint(
              size: Size(triangleSize / 2, triangleSize),
              painter: BubbleDrawTriangle(
                color: color,
                direction: direction,
              ),
            ),
            Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color,
              ),
              child: child,
            ),
          ],
        );
    }
  }
}
