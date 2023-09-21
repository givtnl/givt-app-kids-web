import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/parental_approval/models/decision_response.dart';
import 'package:givt_app_kids_web/features/parental_approval/repository/transaction_decision_repository.dart';

part 'decision_event.dart';
part 'decision_state.dart';

class DecisionBloc extends Bloc<DecisionEvent, DecisionState> {
  DecisionBloc() : super(DecisionInitial()) {
    on<DecisionInit>(_onInit);
  }
  void _onInit(DecisionInit event, Emitter<DecisionState> emit) async {
    emit(state.copyWith(status: DecisionStatus.loading));
    final donationId = int.parse(event.donationId);
    final decision = event.decision;
    final decisionRepository = TransactionDecisionRepository();

    try {
      final DecisionResponse decisionResponse =
          await decisionRepository.submitDecision(
        donationId,
        event.childId,
        decision,
      );
      if (decisionResponse.isError == false) {
        if (!decision) {
          emit(state.copyWith(status: DecisionStatus.declined));
          return;
        }
        emit(state.copyWith(status: DecisionStatus.approved));
        return;
      }

      if (decisionResponse.isError) {
        if (!decision &&
            decisionResponse.errorMessage == 'TRANSACTION_ALREADY_DECLINED') {
          emit(state.copyWith(status: DecisionStatus.declined));
          return;
        }
        if (decision &&
            decisionResponse.errorMessage == 'TRANSACTION_ALREADY_APPROVED') {
          emit(state.copyWith(status: DecisionStatus.approved));
          return;
        }
        emit(state.copyWith(
            status: DecisionStatus.error,
            errorMessage: decisionResponse.errorMessage));
      }
    } catch (e) {
      emit(state.copyWith(
          status: DecisionStatus.error, errorMessage: e.toString()));
    }
  }
}
