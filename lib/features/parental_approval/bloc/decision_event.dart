part of 'decision_bloc.dart';

class DecisionEvent extends Equatable {
  const DecisionEvent({
    this.decision = false,
    this.status = DecisionStatus.initial,
  });
  final bool decision;
  final DecisionStatus status;
  @override
  List<Object> get props => [decision, status];
}

class DecisionInit extends DecisionEvent {
  const DecisionInit();
}
