import 'package:TishApp/TishApp/Services/Place/Place_Type_Repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';

class Place_TypeViewModel with ChangeNotifier {
  late List<Place_Type> _place_type_List = [];

  Future<void> fetchPlace_TypeData() async {
    print("Entered");
    try {
      List<Place_Type> _place_Types =
          await Place_TypeRepository().fetchPlace_TypeList();
      setSelectedPlace_Type(_place_Types);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setSelectedPlace_Type(List<Place_Type> _place_type_List) {
    this._place_type_List.addAll(_place_type_List);
    notifyListeners();
  }

  List<Place_Type> get place_type_List {
    return _place_type_List;
  }
}
