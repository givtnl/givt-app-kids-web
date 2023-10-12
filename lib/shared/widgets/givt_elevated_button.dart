import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class GivtElevatedButton extends StatelessWidget {
  const GivtElevatedButton({
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.isLoading,
    this.onPressed,
    this.showBorder = false,
    required this.padding,
    super.key,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool showBorder;
  final void Function()? onPressed;
  final EdgeInsets padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
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
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: padding,
              child: Opacity(
                opacity: isLoading ? 0 : 1,
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
            ),
          ),
          if (isLoading)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: foregroundColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
