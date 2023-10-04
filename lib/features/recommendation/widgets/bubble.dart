import 'package:flutter/material.dart';

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
              painter: DrawTriangle(
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
              painter: DrawTriangle(
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

enum BubbleDirection {
  above,
  atRight,
}

class DrawTriangle extends CustomPainter {
  DrawTriangle({
    required this.color,
    required this.direction,
  });

  final Color color;
  final BubbleDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    switch (direction) {
      case BubbleDirection.above:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        path.close();
        canvas.drawPath(path, Paint()..color = color);
        break;
      case BubbleDirection.atRight:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        path.close();
        canvas.drawPath(path, Paint()..color = color);
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
