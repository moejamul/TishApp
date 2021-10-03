import 'dart:convert';

import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:TishApp/TishApp/Settings/DioSettings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_Favorite_PlacesService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> getAll() async {
    var responseJson;
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio.get((_baseUrl + '/User_Favorite_Places'));
      print(response.statusCode);
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getOne(int id) async {
    dynamic responseJson;
    try {
      Dio dio = await DioSettings.getDio();
      final response = await dio.get((_baseUrl + '/User_Favorite_Places/$id'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getByEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseJson;
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio
          .get((_baseUrl + '/users/email/${prefs.getString('email')}'));
      print(response.statusCode);
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<bool> insertFavoritePlace(String email, int PlaceID) async {
    Dio dio = await DioSettings.getDio();
    try {
      final response =
          await dio.post((_baseUrl + '/User_Favorite_Places/$email/$PlaceID'));
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> deleteFavoritePlace(String email, int PlaceID) async {
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio
          .delete((_baseUrl + '/User_Favorite_Places/$email/$PlaceID'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> ifFavoritePlaceExists(String email, int PlaceID) async {
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio
          .get((_baseUrl + '/User_Favorite_Places/Exists/$email/$PlaceID'));
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data.toString() == "true" ? true : false;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return false;
  }

  @visibleForTesting
  dynamic returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 204:
        return response.data;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
