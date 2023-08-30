import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'decision_state.dart';

class DecisionCubit extends Cubit<DecisionState> {
  DecisionCubit() : super(DecisionInitial());

  void approve() {
    emit(state.copyWith(status: DecisionStatus.approved));
  }
}
