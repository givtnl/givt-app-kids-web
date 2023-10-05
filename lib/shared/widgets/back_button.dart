import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

import 'package:go_router/go_router.dart';

class BackButton extends StatelessWidget {
  const BackButton({required this.pageName, super.key});

  final String pageName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xFFBFDBFC),
        child: IconButton(
          iconSize: 25,
          onPressed: () {
            AnalyticsHelper.logEvent(
                eventName: AmplitudeEvent.backClicked,
                eventProperties: {'page_name': pageName});
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF54A1EE),
          ),
        ),
      ),
    );
  }
}
