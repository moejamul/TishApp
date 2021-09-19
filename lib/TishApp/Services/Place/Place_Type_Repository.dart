import 'dart:convert';
import 'package:TishApp/TishApp/Services/Place/Place_TypeService.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class Place_TypeRepository {
  Place_TypeService _place_typeService = Place_TypeService();

  Future<List<Place_Type>> fetchPlace_TypeList() async {
    dynamic response = await _place_typeService.get();
    List<Place_Type> list = [];
    final jsonData = await jsonDecode(response);
    //TODO return all types not just the first one
    for (var item in jsonData) {
      Place_Type place_Type = Place_Type.fromJson(item);
      list.add(place_Type);
      print(place_Type);
    }

    return list;
  }
}
