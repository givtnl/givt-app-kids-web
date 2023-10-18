import 'dart:convert';
import 'dart:developer';

import 'package:givt_app_kids_web/core/exceptions/givt_server_exception.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'package:givt_app_kids_web/core/network/token_interceptor.dart';

class APIService {
  APIService(
    this._apiURL,
  );

  Client client = InterceptedClient.build(
    requestTimeout: const Duration(seconds: 10),
    interceptors: [
      TokenInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  String _apiURL;

  String get apiURL => _apiURL;

  void updateApiUrl(String url) {
    _apiURL = url;
  }

  Future<List<dynamic>> fetchTags() async {
    final url = Uri.https(_apiURL, '/givt4kidsservice/v1/Organisation/tags');

    var response = await client.get(url);

    log('get-tags response code: ${response.statusCode}');

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      var decodedBody = json.decode(response.body);
      var itemsList = decodedBody['items'];
      return itemsList;
    }
  }

  Future<List<dynamic>> getRecommendedOrganisations(
      Map<String, dynamic> body) async {
    final url =
        Uri.https(_apiURL, '/givt4kidsservice/v1/Organisation/recommendations');

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    log('get-recommended-organisations status code: ${response.statusCode}');

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      var decodedBody = json.decode(response.body);
      var itemsList = decodedBody['items'] as List<dynamic>;
      return itemsList;
    }
  }

  Future<Map<String, dynamic>> makeDecision(Map<String, dynamic> body) async {
    final url = Uri.https(
        _apiURL, '/givt4kidsservice/v1/transaction/donation-approval');

    var response = await client.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body),
      );
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final url = Uri.https(_apiURL, '/givt4kidsservice/v1/Authentication/login');

    var response = await client.post(
      url,
      body: body,
    );

    log('login status code: ${response.statusCode}');

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  Future<List<dynamic>> fetchProfiles(String parentGuid) async {
    final url = Uri.https(_apiURL, '/givt4kidsservice/v1/User/get-children');

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(parentGuid),
    );

    log('fetch profiles status code: ${response.statusCode}');

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      var decodedBody = jsonDecode(response.body);
      final itemMap = decodedBody['items'];
      return itemMap;
    }
  }

  // Future<Map<String, dynamic>> fetchOrganisationDetails(String mediumId) async {
  //   final url = Uri.https(_apiURL,
  //       'givt4kidsservice/v1/organisation/organisation-detail/$mediumId');

  //   var response = await client.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   log('get organisation details status code: ${response.statusCode}');

  //   if (response.statusCode >= 400) {
  //     throw GivtServerException(
  //       statusCode: response.statusCode,
  //       body: jsonDecode(response.body) as Map<String, dynamic>,
  //     );
  //   } else {
  //     Map<String, dynamic> decodedBody = jsonDecode(response.body);
  //     return decodedBody['item'];
  //   }
  // }

  // Future<void> createTransaction({required Transaction transaction}) async {
  //   final url = Uri.https(
  //       _apiURL, '/givt4kidsservice/v1/transaction/create-transaction');

  //   var response = await client.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(transaction.toJson()),
  //   );

  //   log('create transaction status code: ${response.statusCode}');

  //   log(response.body);

  //   if (response.statusCode >= 400) {
  //     throw GivtServerException(
  //       statusCode: response.statusCode,
  //       body: jsonDecode(response.body) as Map<String, dynamic>,
  //     );
  //   } else {
  //     var decodedBody = jsonDecode(response.body);
  //     log(decodedBody.toString());
  //   }
  // }

  Future<Map<String, dynamic>> refreshToken(Map<String, dynamic> body) async {
    final url = Uri.https(
        _apiURL, '/givt4kidsservice/v1/Authentication/refresh-accesstoken');

    var response = await client.post(
      url,
      body: body,
    );

    log('refresh-accesstoken status code: ${response.statusCode}');

    if (response.statusCode >= 400) {
      throw GivtServerException(
        statusCode: response.statusCode,
        body: jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
  }

  // Future<bool> sendRecommendationEmail({required String id}) async {
  //   final url = Uri.https(_apiURL,
  //       'givt4kidsservice/v1/Email/send-email/$id/Givt4KidsRecommendationEmail');

  //   var response = await client.post(
  //     url,
  //   );

  //   if (response.statusCode >= 400) {
  //     throw GivtServerException(
  //       statusCode: response.statusCode,
  //       body: jsonDecode(response.body) as Map<String, dynamic>,
  //     );
  //   } else {
  //     return true;
  //   }
  // }
}
