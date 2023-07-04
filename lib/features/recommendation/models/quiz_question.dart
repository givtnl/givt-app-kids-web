import 'package:givt_app_kids_web/features/recommendation/models/quiz_question_option.dart';

class QuizQuestion {
  final String question;
  final List<QuizQuestionOption> options;

  QuizQuestion({
    required this.question,
    required this.options,
  });

  static QuizQuestion whereDoYouWantToHelp = QuizQuestion(
    question: 'Where would you like to help?',
    options: [
      QuizQuestionOption.whereCommunity,
      QuizQuestionOption.whereCountry,
      QuizQuestionOption.whereWorld,
    ],
  );
  static QuizQuestion helpPeople = QuizQuestion(
    question: 'I want to help people...',
    options: [
      QuizQuestionOption.learnToRead,
      QuizQuestionOption.helpAnimals,
      QuizQuestionOption.helpHealthy,
      QuizQuestionOption.careForChildren,
      QuizQuestionOption.goToSchool,
      QuizQuestionOption.withDisabilities,
      QuizQuestionOption.thatAreHomeless,
      QuizQuestionOption.getFood,
      QuizQuestionOption.findaHome,
      QuizQuestionOption.protectForests,
      QuizQuestionOption.cleanOceans,
      QuizQuestionOption.afteraDisaster
    ],
  );
}
