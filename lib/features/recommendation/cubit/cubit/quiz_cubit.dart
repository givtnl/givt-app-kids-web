import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/quiz_question.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit()
      : super(QuizInitial(questions: [
          QuizQuestion.whereDoYouWantToHelp,
          QuizQuestion.helpPeople
        ]));
}
