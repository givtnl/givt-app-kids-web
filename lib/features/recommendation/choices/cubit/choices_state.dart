part of 'choices_cubit.dart';

abstract class ChoicesState extends Equatable {
  const ChoicesState({
    required this.location,
    required this.interests,
    required this.questionIndex,
  });
  final Tag location;
  final List<Tag> interests;
  final int questionIndex;
  @override
  List<Object> get props => [location, interests];
}

class ChoicesEmpty extends ChoicesState {
  ChoicesEmpty(
      {super.location = const Tag.empty(),
      super.interests = const [],
      super.questionIndex = 0});
}

class WhereSelected extends ChoicesState {
  WhereSelected(
      {required super.location,
      required super.interests,
      required super.questionIndex});
}

class InterestsSelected extends ChoicesState {
  InterestsSelected(
      {required super.location,
      required super.interests,
      required super.questionIndex});
}
