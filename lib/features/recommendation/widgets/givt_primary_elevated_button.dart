import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/givt_elevated_button.dart';

class GivtPrimaryElevatedButton extends StatelessWidget {
  const GivtPrimaryElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  static const Color _primaryBackgroundColor = Color(0xFF54A1EE);
  static const Color _primaryForegroundColor = Colors.white;

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GivtElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: _primaryBackgroundColor,
      foregroundColor: _primaryForegroundColor, //onPrimaryColor: Colors.white,
    );
  }
}
