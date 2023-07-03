part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState({
    required this.questions,
  });
  final List<QuizQuestion> questions;

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {
  QuizInitial({required super.questions});
}

class QuizFetched extends QuizState {
  QuizFetched({required super.questions});
}
