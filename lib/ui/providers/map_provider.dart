import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  LatLng? myPosition;
  LatLng? placePosition;
  bool isSearchDirection = false;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Sin permisos otorgados');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentPosition() async {
    Position position = await determinePosition();
    myPosition = LatLng(position.latitude, position.longitude);
    isSearchDirection = false;
    notifyListeners();
  }

  Future<void> goNewPosition(String query) async {
    placePosition = const LatLng(10.2299682, -75.4304379);
    isSearchDirection = true;
    notifyListeners();
  }
}
