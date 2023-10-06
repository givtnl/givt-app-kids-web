import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/auth/cubit/auth_cubit.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';
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
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      onPressed: () async {
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
          context.goNamed(Pages.start.name);
        }
      },
      icon: const Icon(Icons.logout_rounded),
      label: const Text('Log out'),
    );
  }
}
