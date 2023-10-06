import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/cubit/profiles_cubit.dart';
import 'package:givt_app_kids_web/features/profiles/models/profile.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({
    required this.pageName,
    super.key,
  });

  final String pageName;

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final anchorSize = size.aspectRatio > 1 ? size.width : size.height;

    return GestureDetector(
      onTap: () async {
        AnalyticsHelper.logEvent(
            eventName: AmplitudeEvent.buttonPressed,
            eventProperties: {
              'button_name': 'Log out',
              'formatted_date': DateTime.now().toIso8601String(),
              'screen_name': widget.pageName,
            });

        final confirmed = await showDialog<bool>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        AnalyticsHelper.logEvent(
                            eventName: AmplitudeEvent.buttonPressed,
                            eventProperties: {
                              'button_name': 'Log out confirmed',
                              'formatted_date':
                                  DateTime.now().toIso8601String(),
                              'screen_name': widget.pageName,
                            });
                        context.pop(true);
                      },
                      child: const Text('YES')),
                  TextButton(
                      onPressed: () => context.pop(false),
                      child: const Text('NO')),
                ],
              );
            });

        if (confirmed == true && mounted) {
          context.read<AuthCubit>().logout();
          context.read<ProfilesCubit>().setActiveProfile(const Profile.empty());

          context.goNamed(Pages.start.name);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
                fontSize: FontUtils.getScaledFontSize(
                  inputFontSize: 18,
                  size: size,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: const Color(0xFFD9D9D9),
                  width: anchorSize * 0.055,
                  height: anchorSize * 0.055,
                  alignment: Alignment.center,
                  child: const Icon(Icons.logout_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
