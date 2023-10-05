import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class GivtContinueButton extends StatelessWidget {
  const GivtContinueButton({
    required this.onPressed,
    super.key,
  });

  static const Color _backgroundColor = Color(0xFFD6EAFF);
  static const Color _foregroundColor = Color(0xFF0E90CC);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        elevation: 0,
        foregroundColor: _foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'continue as guest',
              style: TextStyle(
                color: _foregroundColor,
                fontSize: FontUtils.getScaledFontSize(
                  inputFontSize: 16,
                  size: size,
                ),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                height: 1.2,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.arrow_forward_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
