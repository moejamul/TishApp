import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/Services/Place/PlaceRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class PlaceViewModel with ChangeNotifier {
  late List<Place> _placeList = [];
  late Place _place = Place(
      Created_at: 'null',
      Description: 'null',
      Location: 'null',
      Name: 'null',
      Place_ID: 'null',
      reviews: [],
      earnedBadges: [],
      place_type: Place_Type(Place_Type_ID: 'null', Type: 'null'));

  Future<List<Place>> fetchAll() async {
    try {
      List<Place> response = await PlaceRepository().fetchAllPlace();
      setSelectedPlaceList(response);
      return response;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return [];
  }

  Future<void> fetchOne(int id) async {
    try {
      Place response = await PlaceRepository().fetchOnePlace(id);
      print("response =>>>> $response");
      setSelectedPlace(response);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<List<Place>> fetchByType(String type) async {
    try {
      List<Place> response = await PlaceRepository().fetchPlaceByType(type);
      print("response =>>>> $response");
      setSelectedPlaceList(response);
      return response;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return [];
  }

  void setSelectedPlace(Place place) {
    this._place = place;
    notifyListeners();
  }

  void setSelectedPlaceList(List<Place> place) {
    this._placeList = [];
    this._placeList = place;
    notifyListeners();
  }

  Place get place {
    return _place;
  }

  List<Place> get placeList {
    return _placeList;
  }
}
