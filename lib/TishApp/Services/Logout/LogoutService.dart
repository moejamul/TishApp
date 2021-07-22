import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import '../../Settings/AppSettings.dart';

class LogoutService {
  Settings settings = Settings();
  LocalStorage _localStorage = LocalStorage('UserInfo');

  Future<bool> logoutService() async {
    bool responseJson;
    var accessToken = _localStorage.getItem('access_token');
    var refreshtoken = _localStorage.getItem('jwt')['refresh_token'];
    try {
      final response = await http
          .post(Uri.parse(settings.logout_url), headers: <String, String>{
        "Authorization": "Bearer ${accessToken.toString()}",
        "Content-Type": "application/x-www-form-urlencoded",
      }, body: {
        "client_secret": settings.client_secret_login,
        "client_id": settings.client_id_login,
        "refresh_token": refreshtoken
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
      case 204:
        return true;
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
