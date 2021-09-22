import 'dart:convert';

import 'package:TishApp/TishApp/model/TishAppModel.dart';

import 'PlaceService.dart';

class PlaceRepository {
  PlaceService _placeService = PlaceService();

  Future<List<Place>> fetchAllPlace() async {
    List<Place> list = [];
    dynamic response = await _placeService.getAll();
    for (var item in response) {
      Place place = Place.fromJson(item);
      list.add(place);
      // print(place.Updated_at);
    }
    return list;
  }

  Future<Place> fetchOnePlace(int id) async {
    dynamic response = await _placeService.getOne(id);
    Place place = Place.fromJson(response);
    return place;
  }

  Future<List<Place>> fetchPlaceByType(String type) async {
    List<Place> list = [];
    dynamic response = await _placeService.getByType(type);
    for (var item in response) {
      Place place = Place.fromJson(item);
      list.add(place);
    }
    return list;
  }
}
