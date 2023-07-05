import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;

class OrganizationsDataProvider {
  Future<List<dynamic>> fetchOrganizations() async {
    final url = Uri.https('dev-backend.givt.app',
        '/givt4kidsservice/v1/Organization/get-organizations');

    try {
      final sendbody = jsonEncode(
        {
          "pageSize": 3,
          "range": "USA",
          "tags": ["CLEANOCEANS", "GETFOOD", "CAREFORCHILDREN"]
        },
      );
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: sendbody,
      );

      // log('get-recommended-organizations status code: ${response.statusCode}');

      if (response.statusCode < 400) {
        var decodedBody = json.decode(response.body);
        log('body is $decodedBody');
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
