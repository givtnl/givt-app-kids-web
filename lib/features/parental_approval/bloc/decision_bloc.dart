import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'decision_event.dart';
part 'decision_state.dart';

class DecisionBloc extends Bloc<DecisionEvent, DecisionState> {
  DecisionBloc() : super(DecisionInitial()) {
    on<DecisionInit>(_onInit);
  }
  void _onInit(DecisionInit event, Emitter<DecisionState> emit) async {
    await Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(status: DecisionStatus.approved));
    });
    await Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(status: DecisionStatus.declined));
    });
    await Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(status: DecisionStatus.error));
    });
  }
}
