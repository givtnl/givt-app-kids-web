import 'dart:developer';
import 'dart:convert';

import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:givt_app_kids_web/utils/api_helper.dart';
import 'package:http/http.dart' as http;

class OrganizationsDataProvider {
  Future<List<dynamic>> getRecommendedOrganizations({
    required Tag location,
    required List<Tag> interests,
  }) async {
    final url = Uri.https(ApiHelper.apiURL, ApiHelper.recommendationsPath);

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "range": location.key,
            "pageSize": 3,
            "tags": interests.map((interest) => interest.key).toList(),
          },
        ),
      );

      log('get-recommended-organizations status code: ${response.statusCode}');

      if (response.statusCode < 400) {
        var decodedBody = json.decode(response.body);
        var itemsList = decodedBody['items'] as List<dynamic>;
        return itemsList;
      } else {
        throw Exception(response.body);
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
