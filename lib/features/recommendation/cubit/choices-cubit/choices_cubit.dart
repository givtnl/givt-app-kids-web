import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'choices_state.dart';

class ChoicesCubit extends Cubit<ChoicesState> {
  ChoicesCubit() : super(ChoicesEmpty(interests: [], location: ''));
}
