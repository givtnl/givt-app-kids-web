part of 'choices_cubit.dart';

abstract class ChoicesState extends Equatable {
  const ChoicesState({
    required this.location,
    required this.interests,
  });
  final Tag location;
  final List<Tag> interests;
  @override
  List<Object> get props => [location, interests];
}

class ChoicesEmpty extends ChoicesState {
  ChoicesEmpty(
      {super.location = const Tag.empty(), super.interests = const []});
}

class WhereSelected extends ChoicesState {
  WhereSelected({required super.location, required super.interests});
}

class InterestsSelected extends ChoicesState {
  InterestsSelected({required super.location, required super.interests});
}
