import 'package:givt_app_kids_web/core/network/network.dart';
import 'package:givt_app_kids_web/features/parental_approval/models/decision_response.dart';

mixin TransactionDecisionRepository {
  Future<DecisionResponse> submitDecision(
      int donationId, String childId, bool approved);
}

class TransactionDecisionRepositoryImpl with TransactionDecisionRepository {
  TransactionDecisionRepositoryImpl(
    this._apiService,
  );

  final APIService _apiService;

  @override
  Future<DecisionResponse> submitDecision(
      int donationId, String childId, bool approved) async {
    final response = await _apiService.makeDecision(
      {
        "donationId": donationId,
        "childId": childId,
        "approved": approved,
      },
    );

    final DecisionResponse result = DecisionResponse.fromMap(response);

    return result;
  }
}
