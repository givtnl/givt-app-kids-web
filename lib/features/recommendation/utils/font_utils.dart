class FontUtils {
  static double getScaledFontSize({
    required double inputFontSize,
    required double availableWidth,
    required double availableHeight,
  }) {
    final area = availableWidth * availableHeight;
    return inputFontSize * area * 0.0000055;
  }
}
