import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'LoginService.dart';

class LoginRepository {
  LoginService _loginService = LoginService();

  // ignore: non_constant_identifier_names
  Future<bool> LoginRepo(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic response = await _loginService.loginService(username, password);
    final jsonData = jsonDecode(response);
    await prefs.setString('access_token', jsonData['access_token'].toString());
    Map<String, dynamic>? jwtData = {};
    print(jsonData['access_token']);
    jwtData = Jwt.parseJwt(jsonData['access_token'].toString());
    await prefs.setString('name', jwtData['name'].toString());
    await prefs.setString('refresh_token', jwtData['refresh-token'].toString());
    await prefs.setString('email', jwtData['email'].toString());
    await prefs.setString(
        'email_verified', jwtData['email_verified'].toString());
    await prefs.setString('given_name', jwtData['given_name'].toString());
    await prefs.setString('family_name', jwtData['family_name'].toString());

    await prefs.setBool('IsLoggedIn', true);
    return true;
  }
}
