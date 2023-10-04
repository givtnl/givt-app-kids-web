import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givt_elevated_button.dart';

class GivtSecondaryElevatedButton extends StatelessWidget {
  const GivtSecondaryElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  static const Color _secondaryBackgroundColor = Colors.white;
  static const Color _secondaryForegroundColor = Color(0xFF54A1EE);

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GivtElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: _secondaryBackgroundColor,
      foregroundColor: _secondaryForegroundColor,
      showBorder: true,
    );
  }
}
