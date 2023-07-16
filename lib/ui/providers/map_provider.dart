import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  LatLng? myPosition;
  LatLng? placePosition;

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
    notifyListeners();
  }
}
