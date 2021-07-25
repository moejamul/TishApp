import 'dart:convert';

import 'package:prokit_flutter/TishApp/model/TishAppModel.dart';

import 'PlaceService.dart';

class PlaceRepository {
  PlaceService _placeService = PlaceService();

  Future<Place> fetchPlaceList(String url) async {
    dynamic response = await _placeService.get(url);
    final jsonData = jsonDecode(response);
    Place place = Place.fromJson(jsonData);

    return place;
  }
}
