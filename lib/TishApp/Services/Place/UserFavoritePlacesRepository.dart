import 'dart:convert';
import 'package:TishApp/TishApp/Services/Place/UserFavoritePlacesService.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class User_Favorite_PlacesRepository {
  User_Favorite_PlacesService _User_Favorite_PlacesService =
      User_Favorite_PlacesService();

  Future<List<UserFavoritePlaces>> fetchAllUser_Favorite_Places() async {
    List<UserFavoritePlaces> list = [];
    dynamic response = await _User_Favorite_PlacesService.getAll();
    for (var item in response) {
      UserFavoritePlaces UserFavoritePlace = UserFavoritePlaces.fromJson(item);
      list.add(UserFavoritePlace);
    }
    return list;
  }

  Future<List<UserFavoritePlaces>> fetchUser_Favorite_PlacesByEmail() async {
    List<UserFavoritePlaces> list = [];
    dynamic response = await _User_Favorite_PlacesService.getByEmail();
    for (var item in response['favorite_Places']) {
      if (item['place'] == null) {
        continue;
      }
      print(item);
      UserFavoritePlaces UserFavoritePlace = UserFavoritePlaces.fromJson(item);
      list.add(UserFavoritePlace);
    }
    return list;
  }

  Future<UserFavoritePlaces> fetchOneUser_Favorite_Places(int id) async {
    dynamic response = await _User_Favorite_PlacesService.getOne(id);
    UserFavoritePlaces UserFavoritePlace =
        UserFavoritePlaces.fromJson(response);
    return UserFavoritePlace;
  }

  Future<bool> LikePlace(String email, int PlaceID) async {
    bool response =
        await _User_Favorite_PlacesService.insertFavoritePlace(email, PlaceID);
    return response;
  }

  Future<bool> DislikePlace(String email, int PlaceID) async {
    bool response =
        await _User_Favorite_PlacesService.deleteFavoritePlace(email, PlaceID);
    return response;
  }

  Future<bool> ifalreadyLiked(String email, int PlaceID) async {
    bool response = await _User_Favorite_PlacesService.ifFavoritePlaceExists(
        email, PlaceID);
    return response;
  }
}
