import 'package:localstorage/localstorage.dart';

import 'RegisterService.dart';

class RegisterRepository {
  LocalStorage localStorage = LocalStorage('UserInfo');
  RegisterService _registerService = RegisterService();

  // ignore: non_constant_identifier_names
  Future<bool> RegisterRepo(
    String firstName,
    String lastName,
    String password,
    String email,
  ) async {
    bool response = await _registerService.registerService(
        firstName, lastName, password, email);
    return response;
  }
}
