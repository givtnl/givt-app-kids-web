import 'dart:developer';
import 'dart:convert';

import 'package:givt_app_kids_web/utils/api_helper.dart';
import 'package:http/http.dart' as http;

class TransactionDecisionDataProvider {
  Future<Map<String, dynamic>> makeDecision(String jsonString) async {
    final url = Uri.https(ApiHelper.apiURL, ApiHelper.decisionPath);

    try {
      var response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonString,
      );

      if (response.statusCode < 400) {
        return json.decode(response.body);
      } else {
        throw Exception(response.body);
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
