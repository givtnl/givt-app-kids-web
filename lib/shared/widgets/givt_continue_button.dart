import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

class GivtContinueButton extends StatelessWidget {
  const GivtContinueButton({
    required this.pageName,
    super.key,
  });

  static const Color _backgroundColor = Color(0xFFD6EAFF);
  static const Color _foregroundColor = Color(0xFF0E90CC);

  final String pageName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ElevatedButton(
      onPressed: () {
        AnalyticsHelper.logEvent(
          eventName: AmplitudeEvent.continueAsGuestPressed,
          eventProperties: {'page_name': pageName},
        );

        context.read<AuthCubit>().logout();
        context.read<ProfilesCubit>().clearProfiles();

        context.pushReplacementNamed(Pages.locationSelection.name);
      },
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
