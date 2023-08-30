import 'package:flutter/material.dart';

class SizeUtil {
  static bool tooNarrow(BuildContext context) {
    return (MediaQuery.of(context).orientation == Orientation.portrait) ||
        (MediaQuery.of(context).size.width < 850);
  }

  static double anchorSize(BuildContext context) {
    return MediaQuery.of(context).size.aspectRatio > 1
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
  }
}
