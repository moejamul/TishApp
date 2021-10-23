import 'dart:io';
import 'package:TishApp/TishApp/Settings/DioSettings.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../Settings/AppSettings.dart';

class LoginService {
  Settings settings = Settings();

  Future<dynamic> loginService(String username, String password) async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    Response response;
    try {
      response = await dio.post((settings.login_url),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          }),
          data: {
            "username": username,
            "password": password,
            "grant_type": settings.grant_type_login,
            "client_id": settings.client_id_login,
            "client_secret": settings.client_secret_login,
          });
    } on Exception {
      print("ERROR");
      throw Exception('No Internet Connection');
    }
    return response.data;
  }

  @visibleForTesting
  dynamic returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = (response.data);
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
