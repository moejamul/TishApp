import 'RegisterService.dart';

class RegisterRepository {
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
