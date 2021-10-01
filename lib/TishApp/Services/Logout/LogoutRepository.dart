import 'dart:convert';

import 'package:TishApp/TishApp/screen/TishAppSignUp.dart';
import 'package:TishApp/main.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';

import 'LogoutService.dart';

class LogoutRepository {
  LocalStorage _localStorage = LocalStorage('UserInfo');
  LogoutService _LogoutService = LogoutService();

  // ignore: non_constant_identifier_names
  Future<bool> LogoutRepo() async {
    bool response = await _LogoutService.logoutService();
    response ? _localStorage.clear() : null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('IsLoggedIn', false);
    navigator.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
    return response;
  }
}
