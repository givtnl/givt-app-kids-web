import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/models/quiz_question.dart';
import 'package:givt_app_kids_web/features/recommendation/choices/models/tag.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/repositories/tags_repository.dart';
import 'package:givt_app_kids_web/utils/analytics_helper.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._tagsRepository) : super(QuizInitial(questions: const []));

  final TagsRepository _tagsRepository;

  void startQuiz() async {
    emit(QuizLoading());

    try {
      AnalyticsHelper.logEvent(
        eventName: AmplitudeEvent.recommendationFlowStarted,
      );
      final List<Tag> response = await _tagsRepository.fetchTags();
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
