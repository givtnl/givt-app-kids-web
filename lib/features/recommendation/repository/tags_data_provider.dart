import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TagsDataProvider {
  Future<List<dynamic>> fetchTags() async {
    final url = Uri.https(
        'dev-backend.givtapp.net', '/givt4kidsservice/v1/Organisation/tags');

    try {
      var response = await http.get(url);

      log('get-tags');

      if (response.statusCode < 400) {
        var decodedBody = json.decode(response.body);
        var itemsList = decodedBody['items'];
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
