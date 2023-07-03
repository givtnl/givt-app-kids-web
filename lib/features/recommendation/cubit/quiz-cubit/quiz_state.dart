part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState({
    required this.where,
    required this.interests,
  });
  final String where;
  final List interests;
  @override
  List<Object> get props => [where, interests];
}

class QuizInitial extends QuizState {
  QuizInitial({required super.where, required super.interests});
}

class QuizWhereSelected extends QuizState {
  QuizWhereSelected({required super.where, required super.interests});
}

class QuizInterestsSelected extends QuizState {
  QuizInterestsSelected({required super.where, required super.interests});
}
