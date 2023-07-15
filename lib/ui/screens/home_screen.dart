// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../config/constants/envrioment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CupertinoSearchTextField(
          autocorrect: true,
          placeholder: 'Buscar lugares...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 20),
                _Title(title: 'Datos del perfil'),
                _ItemDrawer(
                  label: 'Nombres:',
                  value: 'Didier David',
                ),
                _ItemDrawer(
                  label: 'Apellidos:',
                  value: 'Junco Pérez',
                ),
                _ItemDrawer(
                  label: 'Correo:',
                  value: 'dididi@gmail.com',
                ),
                Divider(),
                Expanded(child: SizedBox()),
                _ExitButton()
              ],
            ),
          ),
        ),
      ),
      body: HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on_outlined),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class _ItemDrawer extends StatelessWidget {
  final String label;
  final String value;
  const _ItemDrawer({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  const _ExitButton();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/'),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Salir',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.exit_to_app),
        ],
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
        zoom: 18,
        rotationWinGestures: MultiFingerGesture.none,
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
        MarkerLayer(
          markers: [
            Marker(
              point: myPosition,
              builder: (context) => const Icon(
                Icons.location_on_outlined,
                color: Colors.purpleAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
