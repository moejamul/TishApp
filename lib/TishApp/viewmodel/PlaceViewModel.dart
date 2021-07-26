import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/Services/Place/PlaceRepository.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class PlaceViewModel with ChangeNotifier {
  // ApiResponse _apiResponse = ApiResponse.loading('Fetching artist data');

  late Place _place =
      Place(completed: 'null', id: 'null', title: 'test title', userId: 'null');

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
