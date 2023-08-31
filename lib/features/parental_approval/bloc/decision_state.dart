part of 'decision_bloc.dart';

enum DecisionStatus {
  initial,
  loading,
  approved,
  declined,
  error,
}

class DecisionState extends Equatable {
  const DecisionState({
    this.decision = true,
    this.status = DecisionStatus.initial,
    this.errorMessage = '',
  });

  final bool decision;
  final DecisionStatus status;
  final String errorMessage;

  @override
  List<Object> get props => [decision, status, errorMessage];

  DecisionState copyWith({
    bool? decision,
    DecisionStatus? status,
    String? errorMessage,
  }) {
    return DecisionState(
        decision: decision ?? this.decision,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class DecisionInitial extends DecisionState {}
