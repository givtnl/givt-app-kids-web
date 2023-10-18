import 'package:flutter/material.dart';

enum BubbleDirection {
  above,
  atRight,
}

class BubbleDrawTriangle extends CustomPainter {
  BubbleDrawTriangle({
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
