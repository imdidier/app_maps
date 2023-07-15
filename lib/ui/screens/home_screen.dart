// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../config/constants/envrioment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas'),
        centerTitle: true,
      ),
      body: HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.pin_drop_outlined),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  LatLng myPosition = const LatLng(10.4093098, -75.4601968);
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: myPosition,
        minZoom: 5,
        maxZoom: 25,
        zoom: 16,
      ),
      nonRotatedChildren: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
          additionalOptions: {
            'accessToken': Environment.tokenMapBox,
            'id': 'imdidierjunco/cljn6091a00ls01qpddxn27vk',
          },
        ),
      ],
    );
  }
}
