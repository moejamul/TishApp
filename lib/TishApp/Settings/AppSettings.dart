class Settings {
  static const String _grant_type_login = 'password';
  static const String _client_id_login = 'TishAppLogin';
  static const String _grant_type_register = 'client_credentials';
  static const String _client_id_register = 'TishAppRegister';
  static const String _client_secret_register =
      '78b65236-7d4b-4dd8-ab00-24c280bf3b63';
  static const String _login_url =
      'http://dev.codepickles.com:8080/auth/realms/TishApp/protocol/openid-connect/token';
  static const String _Register_url =
      'http://dev.codepickles.com:8080/auth/admin/realms/TishApp/users';

  Settings();

  String get grant_type_login {
    return _grant_type_login;
  }

  String get client_id_login {
    return _client_id_login;
  }

  String get grant_type_register {
    return _grant_type_register;
  }

  String get client_id_register {
    return _client_id_register;
  }

  String get client_secret_register {
    return _client_secret_register;
  }

  String get login_url {
    return _login_url;
  }

  String get Register_url {
    return _Register_url;
  }
}
