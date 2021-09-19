import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../Settings/AppSettings.dart';

class RegisterService {
  Settings settings = Settings();

  Future<bool> registerService(
      String firstName, String lastName, String password, String email) async {
    dynamic responseJson, result;
    try {
      final response = await http.post(Uri.parse(settings.login_url), headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }, body: {
        "client_secret": settings.client_secret_register,
        "grant_type": settings.grant_type_register,
        "client_id": settings.client_id_register
      });
      responseJson = jsonDecode(returnResponse(response));
      String accessToken = responseJson['access_token'];
      var temp = {
        "username": '$firstName',
        "enabled": 'true',
        "emailVerified": 'true',
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "credentials": [
          {"type": "password", "value": password, "temporary": "false"}
        ]
      };
      var data = jsonEncode(temp);
      final responseRegister = await http.post(Uri.parse(settings.Register_url),
          headers: {
            'Authorization': 'Bearer $accessToken',
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: data);
      await AddToDB(firstName, lastName, email, accessToken);
      result = returnResponse(responseRegister);
    } on SocketException {
      print("ERROR");
      throw Exception('No Internet Connection');
    }
    return true;
  }

  Future<bool> AddToDB(String firstName, String lastName, String email,
      String accessToken) async {
    try {
      var temp = {
        "Username": '$firstName $lastName',
        "Email": email,
      };
      var data = jsonEncode(temp);
      final responseRegister =
          await http.post(Uri.parse(settings.save_User_In_DB_url),
              headers: {
                'Authorization': 'Bearer $accessToken',
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
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
