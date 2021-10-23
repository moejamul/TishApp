import 'dart:convert';
import 'package:TishApp/TishApp/Services/Place/Place_BadgeService.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class Place_BadgeRepository {
  Place_BadgeService _place_typeService = Place_BadgeService();

  Future<List<Place_Badge>> fetchPlace_BadgeList() async {
    dynamic response = await _place_typeService.get();
    List<Place_Badge> list = [];
    final jsonData = await jsonDecode(response);
    //TODO return all types not just the first one
    for (var item in jsonData) {
      Place_Badge place_Badge = Place_Badge.fromJson(item);
      list.add(place_Badge);
      print(place_Badge);
    }

    return list;
  }
}
