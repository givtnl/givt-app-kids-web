import 'package:flutter/material.dart';

class FontUtils {
  static double getScaledFontSize({
    required double inputFontSize,
    required Size size,
  }) {
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;
    final fontSizeMultiplier = anchorSize * 0.0009;
    return inputFontSize * fontSizeMultiplier;
  }
}
