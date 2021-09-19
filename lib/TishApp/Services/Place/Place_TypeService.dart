import 'dart:convert';
import 'dart:io';
import 'package:TishApp/TishApp/Services/httpInterceptor.dart';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class Place_TypeService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;
  var token;
  var headers;

  Future<dynamic> get() async {
    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [
        HttpInterceptor(),
      ]);
      print(_baseUrl + '/Place_Type');
      final response = await client.get(Uri.parse(_baseUrl + '/Place_Type'));
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
