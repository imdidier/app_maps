import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  LatLng? myPosition;
  LatLng? placePosition;
  bool isSearchDirection = false;
  final MapController mapController = MapController();
  Future<void> trasladarAMiDireccion() async {
    // final String accessToken =
    //     "TU_TOKEN_DE_ACCESO"; // Reemplaza con tu token de acceso de Mapbox
    // final String apiUrl =
    //     "https://api.mapbox.com/geocoding/v5/mapbox.places/$direccion.json?access_token=$accessToken";

    try {
      // final response = await http.get(Uri.parse(apiUrl));

      // if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      // final double latitud = data['features'][0]['center'][1];
      // final double longitud = data['features'][0]['center'][0];

      mapController.move(const LatLng(10.2299682, -75.4304379), 15.0);
      // } else {
      //   print("Error en la consulta: ${response.statusCode}");
      // }
    } catch (e) {
      print("Error: $e");
    }
  }

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
    mapController.move(LatLng(position.latitude, position.longitude), 15.0);
    isSearchDirection = false;
    notifyListeners();
  }

  Future<void> goNewPosition(String query) async {
    placePosition = const LatLng(10.2299682, -75.4304379);
    await trasladarAMiDireccion();
    isSearchDirection = true;
    notifyListeners();
  }
}
