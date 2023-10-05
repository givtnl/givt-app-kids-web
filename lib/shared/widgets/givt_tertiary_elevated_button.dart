import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_elevated_button.dart';

class GivtTertiaryElevatedButton extends StatelessWidget {
  const GivtTertiaryElevatedButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  static const Color _tertiaryBackgroundColor = Color(0xFFE28D4D);
  static const Color _tertiaryForegroundColor = Colors.white;

  final String text;
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GivtElevatedButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: _tertiaryBackgroundColor,
      foregroundColor: _tertiaryForegroundColor,
      isLoading: isLoading,
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 12),
    );
  }
}
