import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/quiz_question.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/repository/tags_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial(questions: []));

  void startQuiz() async {
    emit(QuizLoading());
    final tagsRepository = TagsRepository();
    try {
      final List<Tag> response = await tagsRepository.fetchTags();
      // emit Quiz started
      emit(QuizStarted(questions: [
        QuizQuestion(
          question: 'Where would you like to help?',
          options: response
              .where((element) => element.type == TagType.LOCATION)
              .toList(),
        ),
        QuizQuestion(
          question: 'I want to help people...',
          options: response
              .where((element) => element.type == TagType.INTERESTS)
              .toList(),
        ),
      ]));
    } catch (error) {
      // emit error
    }
  }
}
