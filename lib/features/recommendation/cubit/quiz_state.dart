part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState({
    required this.questions,
  });
  final List<QuizQuestion> questions;

  @override
  List<Object> get props => [questions];
}

class QuizInitial extends QuizState {
  QuizInitial({required super.questions});
}

class QuizStarted extends QuizState {
  QuizStarted({required super.questions});
}

class QuizError extends QuizState {
  QuizError({required super.questions});
}
