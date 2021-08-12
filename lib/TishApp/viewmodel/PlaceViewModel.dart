import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/Services/Place/PlaceRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class PlaceViewModel with ChangeNotifier {
  late Place _place = Place(
      Location: 'null',
      Place_ID: 'null',
      Name: 'test title',
      Description: 'null',
      Created_at: 'null',
      Place_Type_ID: 'null');

  Future<void> fetchPlaceData(String value) async {
    try {
      Place _places = await PlaceRepository().fetchPlaceList(value);
      setSelectedPlace(_places);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setSelectedPlace(Place place) {
    this._place = place;
    notifyListeners();
  }

  Place get place {
    return _place;
  }
}
