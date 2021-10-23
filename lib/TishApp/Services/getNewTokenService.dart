import 'dart:convert';
import 'package:TishApp/TishApp/Services/Logout/LogoutRepository.dart';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

RefreshToken(String refreshToken) async {
  try {
    final response = await http.post(Uri.parse(Settings().login_url), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "refresh_token": refreshToken,
      "grant_type": "refresh_token",
      "client_id": Settings().client_id_login,
    });
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      Map<String, dynamic> jwtData = {};
      JwtDecoder.decode(temp['access_token'])!.forEach((key, value) {
        jwtData[key] = value;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", temp['access_token']);
      // await prefs.setString("refreshToken", temp['refresh_token']);
      await prefs.setInt("tokenDuration", jwtData['exp'] - jwtData['iat']);
      await prefs.setInt("tokenStartTime", jwtData['iat']);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "Session Expired",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black87,
          fontSize: 16.0);
      await LogoutRepository().LogoutRepo();
      return false;
    }
  } on Exception catch (e) {
    Fluttertoast.showToast(
        msg: "Session Expired" + e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black87,
        fontSize: 16.0);
    await LogoutRepository().LogoutRepo();
    return false;
  }
}
