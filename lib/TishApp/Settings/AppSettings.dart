class Settings {
  static const String _Realm_Name = 'TishApp';
  static const String _domain_name = 'dev.codepickles.com';
  static const String _port_number = '8443';
  static const String _grant_type_login = 'password';
  static const String _client_id_login = 'TishAppLogin';
  static const String _grant_type_register = 'client_credentials';
  static const String _client_id_register = 'TishAppRegister';
  static const String _client_secret_register =
      '40a29aa7-280c-4615-8e2d-8c802760a6ff';

  static const String _client_secret_login =
      'efc14a53-2655-42a5-9cb5-c0bd8bd2c6b6';
  static const String _login_url =
      'https://$_domain_name:$_port_number/auth/realms/$_Realm_Name/protocol/openid-connect/token';
  static const String _Register_url =
      'https://$_domain_name:$_port_number/auth/admin/realms/$_Realm_Name/users';
  static const String _logout_url =
      'https://$_domain_name:$_port_number/auth/realms/$_Realm_Name/protocol/openid-connect/logout';

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

  String get logout_url {
    return _logout_url;
  }

  String get client_secret_login {
    return _client_secret_login;
  }
}
