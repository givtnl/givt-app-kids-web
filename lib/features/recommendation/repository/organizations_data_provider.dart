import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;

class OrganizationsDataProvider {
  Future<List<dynamic>> fetchOrganizations() async {
    final url = Uri.https('dev-backend.givt.app',
        '/givt4kidsservice/v1/Organization/get-organizations');

    try {
      var response = await http.get(
        url,
        // headers: {
        //   'Access-Control-Allow-Origin': 'https://dev-backend.givt.app',
        // }
      );

      log('get-organizations status code: ${response.statusCode}');

      if (response.statusCode < 400) {
        var decodedBody = json.decode(response.body) as List<dynamic>;
        return decodedBody;
      } else {
        throw Exception(response.body);
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
