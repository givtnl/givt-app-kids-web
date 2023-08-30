part of 'decision_cubit.dart';

enum DecisionStatus {
  initial,
  loading,
  approved,
  declined,
  error,
}

class DecisionState extends Equatable {
  const DecisionState({
    this.decision = false,
    this.status = DecisionStatus.initial,
  });
  final bool decision;
  final DecisionStatus status;
  @override
  List<Object> get props => [decision, status];
  DecisionState copyWith({
    bool? decision,
    DecisionStatus? status,
  }) {
    return DecisionState(
      decision: decision ?? this.decision,
      status: status ?? this.status,
    );
  }
}

class DecisionInitial extends DecisionState {}
