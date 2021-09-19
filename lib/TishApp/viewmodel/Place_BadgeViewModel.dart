import 'package:TishApp/TishApp/Services/Place/Place_Badge_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class Place_BadgeViewModel with ChangeNotifier {
  late List<Place_Badge> _place_type_List = [];

  Future<void> fetchPlace_BadgeData() async {
    try {
      List<Place_Badge> _place_Types =
          await Place_BadgeRepository().fetchPlace_BadgeList();
      setSelectedPlace_Badge(_place_Types);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setSelectedPlace_Badge(List<Place_Badge> _place_type_List) {
    this._place_type_List.addAll(_place_type_List);
    notifyListeners();
  }

  List<Place_Badge> get place_type_List {
    return _place_type_List;
  }
}
