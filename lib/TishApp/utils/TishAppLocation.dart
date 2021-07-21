import 'package:location/location.dart';

class TishAppLocation {
  Location location = new Location();

  TishAppLocation();

  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  Future<bool> checkIfEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkForPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<Location> getUserLocation() async {
    Location _locationData = Location();
    if (await checkIfEnabled() && await checkForPermission()) {
      _locationData = await location.getLocation() as Location;
    }
    return _locationData;
  }
}
