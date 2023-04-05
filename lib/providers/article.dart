import 'dart:convert';

import 'package:teknikaltest/utils/api_client.dart';
import 'package:http/http.dart' show Response;

class Article {
  static const uri = "innocent/newsapp/articles";
  Future<Response> getArticle() async {
    var response = await client.getData(endPoint: uri);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }
}
