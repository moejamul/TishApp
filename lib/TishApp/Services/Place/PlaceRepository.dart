import 'dart:convert';

import 'package:TishApp/TishApp/model/TishAppModel.dart';

import 'PlaceService.dart';

class PlaceRepository {
  PlaceService _placeService = PlaceService();

  Future<List<Place>> fetchAllPlace() async {
    List<Place> list = [];
    dynamic response = await _placeService.getAll();
    final jsonData = await jsonDecode(response);
    for (var item in jsonData) {
      Place place = Place.fromJson(item);
      list.add(place);
    }
    return list;
  }

  Future<Place> fetchOnePlace(int id) async {
    dynamic response = await _placeService.getOne(id);
    final jsonData = await jsonDecode(response);
    Place place = Place.fromJson(jsonData);
    return place;
  }
}
