part of 'choices_cubit.dart';

abstract class ChoicesState extends Equatable {
  const ChoicesState({
    required this.location,
    required this.interests,
  });
  final String location;
  final List<String> interests;
  @override
  List<Object> get props => [location, interests];
}

class ChoicesEmpty extends ChoicesState {
  ChoicesEmpty({required super.location, required super.interests});
}

class WhereSelected extends ChoicesState {
  WhereSelected({required super.location, required super.interests});
}

class InterestsSelected extends ChoicesState {
  InterestsSelected({required super.location, required super.interests});
}
