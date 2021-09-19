import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../Settings/AppSettings.dart';

class LoginService {
  Settings settings = Settings();

  Future<dynamic> loginService(String username, String password) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(settings.login_url), headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }, body: {
        "username": username,
        "password": password,
        "grant_type": settings.grant_type_login,
        "client_id": settings.client_id_login,
        "client_secret": settings.client_secret_login,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      print("ERROR");
      throw Exception('No Internet Connection');
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
