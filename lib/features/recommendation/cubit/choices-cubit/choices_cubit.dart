import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

part 'choices_state.dart';

class ChoicesCubit extends Cubit<ChoicesState> {
  ChoicesCubit() : super(ChoicesEmpty());

  void chooseLocation(Tag location) {
    log('User chose location ${location.displayText}');
    emit(WhereSelected(interests: state.interests, location: location));
  }
}
