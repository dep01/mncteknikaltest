import 'package:teknikaltest/utils/session.dart';
import 'package:http/http.dart' show Client, Response;

const String baseUrl = "https://60a4954bfbd48100179dc49d.mockapi.io/api/";

class ApiClient {
  Client http = new Client();

  Future<Response> getData({String endPoint}) {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    return http.get(baseUrl + endPoint, headers: headers);
  }
}

final client = new ApiClient();
