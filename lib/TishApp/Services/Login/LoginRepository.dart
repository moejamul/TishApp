import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';

import 'LoginService.dart';

class LoginRepository {
  LocalStorage localStorage = LocalStorage('UserInfo');
  LoginService _loginService = LoginService();

  // ignore: non_constant_identifier_names
  Future<bool> LoginRepo(String username, String password) async {
    dynamic response = await _loginService.loginService(username, password);
    final jsonData = jsonDecode(response);
    await localStorage.ready
        ? await localStorage.setItem(
            'access_token', jsonData['access_token'].toString())
        // ignore: unnecessary_statements
        : null;
    Map<String, dynamic> jwtData = {};
    JwtDecoder.decode(jsonData['access_token'].toString())!
        .forEach((key, value) {
      jwtData[key] = value;
    });
    print(jwtData);
    await localStorage.setItem('name', jwtData['name'].toString());
    await localStorage.setItem('email', jwtData['email'].toString());
    await localStorage.setItem(
        'email_verified', jwtData['email_verified'].toString());
    await localStorage.setItem('given_name', jwtData['given_name'].toString());
    await localStorage.setItem(
        'family_name', jwtData['family_name'].toString());
    return true;
  }
}
