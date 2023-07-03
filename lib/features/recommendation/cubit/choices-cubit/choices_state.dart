part of 'choices_cubit.dart';

abstract class ChoicesState extends Equatable {
  const ChoicesState({
    required this.where,
    required this.interests,
  });
  final String where;
  final List<String> interests;
  @override
  List<Object> get props => [where, interests];
}

class ChoicesEmpty extends ChoicesState {
  ChoicesEmpty({required super.where, required super.interests});
}

class WhereSelected extends ChoicesState {
  WhereSelected({required super.where, required super.interests});
}

class InterestsSelected extends ChoicesState {
  InterestsSelected({required super.where, required super.interests});
}
