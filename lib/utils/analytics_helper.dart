import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';

enum AmplitudeEvent {
  donatePressed('donate_pressed'),
  learnMorePressed('learn_more_pressed'),
  backPressed('back_pressed'),
  charityCardPressed('charity_card_pressed'),
  nextToCharitiesPressed('next_to_charities_pressed'),
  loginPressed('login_pressed'),
  locationSelected('location_selected'),
  charitiesShown('charities_shown'),
  profilePressed('profile_pressed'),
  recommendationFlowStarted('recommendation_flow_started'),
  restartPressed('restart_pressed'),
// new events
  continueAsGuestPressed('continue_as_guest_pressed'),
  loginToDiscoverPressed('login_to_discover_pressed'),
  passwordEyeSwitched('password_eye_switched'),
  profileSwitchButtonPressed('profile_switch_button_pressed'),
  nextToInterestsPressed('next_to_interests_pressed'),
  logoutButtonPressed('logout_button_pressed'),
  logoutDialogConfirmed('logout_dialog_confirmed'),
  logoutDialogCanceled('logout_dialog_canceled'),
  profilesOverlayCanceled('profiles_overlay_canceled'),
  interestSelected('interest_selected'),
  ;

  final String value;

  const AmplitudeEvent(this.value);
}

class AnalyticsHelper {
  static Amplitude? _amplitude;

  static Future<void> init(String key) async {
    _amplitude = Amplitude.getInstance();
    await _amplitude!.init(key);
    await _amplitude!.enableCoppaControl();
    await _amplitude!.trackingSessionEvents(true);
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
