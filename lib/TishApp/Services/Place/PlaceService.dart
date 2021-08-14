import 'dart:convert';
import 'dart:io';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

class PlaceService {
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      print('START');
      final response = await http.get(Uri.parse(_baseUrl + url));
      print('BAAD');
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    } on Exception catch (e) {
      print(e);
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
