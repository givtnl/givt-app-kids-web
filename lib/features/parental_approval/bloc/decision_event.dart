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
  const DecisionInit({
    this.donationId = '',
    this.childId = '',
    this.decision = false,
  });
  final String donationId;
  final String childId;
  final bool decision;

  @override
  List<Object> get props => [donationId, childId, decision];
}
