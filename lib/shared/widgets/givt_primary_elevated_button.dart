import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_elevated_button.dart';

class GivtPrimaryElevatedButton extends StatelessWidget {
  const GivtPrimaryElevatedButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 45, vertical: 12),
    super.key,
  });

  static const Color _primaryBackgroundColor = Color(0xFF54A1EE);
  static const Color _primaryForegroundColor = Colors.white;

  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GivtElevatedButton(
      text: text,
      padding: padding,
      onPressed: onPressed,
      backgroundColor: _primaryBackgroundColor,
      foregroundColor: _primaryForegroundColor,
      isLoading: isLoading,
    );
  }
}
