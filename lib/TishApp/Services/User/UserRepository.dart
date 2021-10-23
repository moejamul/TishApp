import 'dart:convert';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

import 'UserService.dart';

class UserRepository {
  UserService _UserService = UserService();

  Future<List<User>> fetchAllUser() async {
    List<User> list = [];
    dynamic response = await _UserService.getAll();
    for (var item in response) {
      User UserFavoritePlace = User.fromJson(item);
      list.add(UserFavoritePlace);
    }
    return list;
  }

  Future<User> fetchUserByEmail() async {
    dynamic response = await _UserService.getByEmail();
    User user = User.fromJson(response);
    return user;
  }

  Future<User> fetchOneUser(int id) async {
    dynamic response = await _UserService.getOne(id);
    User user = User.fromJson(response);
    return user;
  }
}
