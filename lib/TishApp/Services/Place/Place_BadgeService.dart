import 'dart:convert';
import 'dart:io';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class Place_BadgeService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;
  LocalStorage _localStorage = LocalStorage('UserInfo');
  var token;
  var headers;

  Future<void> PrepareHeader() async {
    token = await _localStorage.getItem("access_token");
    headers = {"Accept": "application/json", 'Authorization': 'Bearer $token'};
  }

  Future<dynamic> get() async {
    dynamic responseJson;
    try {
      await PrepareHeader();
      final response = await http.get(Uri.parse(_baseUrl + '/Place_Badge'),
          headers: headers);
      print(response.statusCode);
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = (response.body);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
