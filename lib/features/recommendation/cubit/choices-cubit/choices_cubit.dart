import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

part 'choices_state.dart';

class ChoicesCubit extends Cubit<ChoicesState> {
  ChoicesCubit() : super(ChoicesEmpty());

  void chooseLocation(Tag location) {
    log('User chose location ${location.displayText}');
    emit(WhereSelected(
        interests: state.interests, location: location, questionIndex: 0));
    AnalyticsHelper.logEvent(
      eventName: AmplitudeEvent.whereToHelpClicked,
      eventProperties: {
        "choice": '${location.displayText}',
      },
    );
  }

  void chooseInterest(Tag interest) {
    final chosenInterests = state.interests;
    final interests = chosenInterests.contains(interest)
        ? chosenInterests.where((element) => element != interest).toList()
        : chosenInterests.length >= 3
            ? chosenInterests
            : [...chosenInterests, interest];
    log('User chose interest ${interest.displayText}, total choices: ${interests.length}');

    emit(InterestsSelected(
        interests: interests, location: state.location, questionIndex: 1));
  }

  void fromWhereToInterest() {
    emit(InterestsSelected(
        interests: state.interests,
        location: state.location,
        questionIndex: 1));
    AnalyticsHelper.logEvent(
      eventName: AmplitudeEvent.nextClicked,
    );
  }
}
