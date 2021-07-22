import 'dart:convert';

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
    return response;
  }
}
