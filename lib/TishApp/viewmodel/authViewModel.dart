import 'package:flutter/cupertino.dart';
import 'package:prokit_flutter/TishApp/Services/Login/LoginRepository.dart';
import 'package:prokit_flutter/TishApp/Services/Register/RegisterRepository.dart';

class AuthViewModel with ChangeNotifier {
  // ApiResponse _apiResponse = ApiResponse.loading('Fetching artist data');

  late bool _login_response = false;
  late bool _register_response = false;

  // ignore: non_constant_identifier_names
  Future<void> Login(String username, String password) async {
    try {
      setLoginResponse(false);
      bool response = await LoginRepository().LoginRepo(username, password);
      setLoginResponse(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future<void> Register(
      String firstName, String lastName, String password, String email) async {
    try {
      setRegisterResponse(false);
      bool response = await RegisterRepository()
          .RegisterRepo(firstName, lastName, password, email);
      setRegisterResponse(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setLoginResponse(bool response) {
    _login_response = response;
    notifyListeners();
  }

  void setRegisterResponse(bool response) {
    _register_response = response;
    notifyListeners();
  }

  bool get login_response {
    return _login_response;
  }

  bool get register_response {
    return _register_response;
  }
}
