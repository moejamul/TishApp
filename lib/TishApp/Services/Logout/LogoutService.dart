import 'package:shared_preferences/shared_preferences.dart';

class LogoutService {
  Future<bool> logoutService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
