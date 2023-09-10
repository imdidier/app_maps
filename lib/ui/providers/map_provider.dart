import 'dart:async';

import 'package:app_maps_2/config/constants/envrioment.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  GoogleMapController? mapController;
  LatLng? myPosition;
  LatLng? placePosition;
  bool isSearchDirection = false;
  List<Map<String, dynamic>> addressList = [];
  Future<void> trasladarAMiDireccion(String query) async {
    try {} catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
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
    mapController!.animateCamera(CameraUpdate.newLatLng(myPosition!));
    notifyListeners();
  }

  Future<void> goNewPosition(Map<String, dynamic> address) async {
    final lat = address['lat'];
    final lng = address['lng'];
    myPosition = null;
    placePosition = LatLng(lat, lng);
    mapController!.animateCamera(CameraUpdate.newLatLng(placePosition!));
    notifyListeners();
  }

  Future<void> searchAddress(String address) async {
    try {
      if (address != '') {
        addressList.clear();
        final apiKey = Environment.apiKeyGoogleMaps;
        final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final result = data['results'] as List<dynamic>;
          if (result.isNotEmpty) {
            if (result.length > 5) result.sublist(1, 4);
            addressList = [...result];
          }
          notifyListeners();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('MapProvider, searchAddress Error: $e');
      }
    }
  }
}
