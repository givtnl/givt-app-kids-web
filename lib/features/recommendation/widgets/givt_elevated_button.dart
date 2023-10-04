import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class GivtElevatedButton extends StatelessWidget {
  const GivtElevatedButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.showBorder = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 45, vertical: 12),
    super.key,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool showBorder;
  final void Function() onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 5,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          side: showBorder
              ? BorderSide(
                  color: foregroundColor,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: FontUtils.getScaledFontSize(
              inputFontSize: 20,
              size: size,
            ),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
