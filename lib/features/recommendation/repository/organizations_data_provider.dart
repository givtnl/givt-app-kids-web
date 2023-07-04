import 'dart:developer';
import 'dart:convert';

import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';
import 'package:http/http.dart' as http;

class OrganizationsDataProvider {
  Future<List<dynamic>> getRecommendedOrganizations(List<Tag> inputTags) async {
    final url = Uri.https('dev-backend.givtapp.net',
        'givt4kidsservice/v1/Organisation/recommendations');

    try {
      final locationTag =
          inputTags.firstWhere((tag) => tag.type == TagType.location);
      final interestTags = inputTags
          .takeWhile((tag) => tag.type == TagType.interest)
          .map((tag) => tag.key)
          .toList();
      var response = await http.post(url,
          body: jsonEncode({
            {
              "range": locationTag.key,
              "pageSize": 3,
              "tags": interestTags,
            }
          }));

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
