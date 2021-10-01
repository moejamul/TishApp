import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'LoginService.dart';

class LoginRepository {
  LoginService _loginService = LoginService();

  // ignore: non_constant_identifier_names
  Future<bool> LoginRepo(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _loginService.loginService(username, password);
    final jsonData = (response);
    Map<String, dynamic>? jwtData = {};
    print(jsonData['access_token']);
    jwtData = Jwt.parseJwt(jsonData['access_token'].toString());
    await prefs.setString("accessToken", jsonData['access_token']);
    await prefs.setString("refreshToken", jsonData['refresh_token']);
    await prefs.setString("UserID", jwtData['sub']);
    await prefs.setInt("tokenDuration", jsonData['expires_in']);
    await prefs.setInt("refreshDuration", jsonData['refresh_expires_in']);
    await prefs.setInt("tokenStartTime", jwtData['iat']);
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
