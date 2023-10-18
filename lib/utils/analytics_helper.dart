import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';

enum AmplitudeEvent {
  backClicked('back_clicked'),
  charitiesShown('charities_shown'),
  charityClicked('charity_clicked'),
  donateClicked('donate_clicked'),
  helpPeopleClicked('help_people_clicked'),
  learnMoreClicked('learn_more_clicked'),
  nextClicked('next_clicked'),
  recommendationFlowStarted('recommendation_flow_started'),
  restartClicked('restart_clicked'),
  whereToHelpClicked('where_to_help_clicked'),
  ;

  final String value;

  const AmplitudeEvent(this.value);
}

class AnalyticsHelper {
  static Amplitude? _amplitude;

  static Future<void> init(String key) async {
    // commented out to disable tracking.

    // _amplitude = Amplitude.getInstance();
    // await _amplitude!.init(key);
    // await _amplitude!.enableCoppaControl();
    // await _amplitude!.trackingSessionEvents(true);
  }

  static Future<void> setUserId(String profileName) async {
    final currentUserId = await _amplitude?.getUserId();
    final isNewUser = profileName != currentUserId;

    log('The ${isNewUser ? 'new' : 'same'} amplitude user $profileName is set');
    await _amplitude?.setUserId(profileName, startNewSession: isNewUser);
  }

  static Future<void> logEvent({
    required AmplitudeEvent eventName,
    Map<String, dynamic>? eventProperties,
  }) async {
    await _amplitude?.logEvent(
      eventName.value,
      eventProperties: eventProperties,
    );

    log('${eventName.value} pressed with properties: $eventProperties');
  }
}
