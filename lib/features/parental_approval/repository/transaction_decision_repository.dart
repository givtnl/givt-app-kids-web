import 'dart:convert';

import 'package:givt_app_kids_web/features/parental_approval/models/decision_response.dart';
import 'package:givt_app_kids_web/features/parental_approval/repository/transaction_decision_data_provider.dart';

class TransactionDecisionRepository {
  Future<DecisionResponse> submitDecision(
      int donationId, String childId, bool approved) async {
    final bffBackend = TransactionDecisionDataProvider();

    final String jsonString = jsonEncode(
      {"donationId": donationId, "childId": childId, "approved": approved},
    );
    final response = await bffBackend.makeDecision(jsonString);

    final DecisionResponse result = DecisionResponse.fromMap(response);

    return result;
  }
}
