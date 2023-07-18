// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../config/constants/envrioment.dart';
import '../providers/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapProvider mapProvider;
  bool? isSearchDirection;
  @override
  void didChangeDependencies() {
    mapProvider = Provider.of<MapProvider>(context);
    isSearchDirection = mapProvider.isSearchDirection;
    super.didChangeDependencies();
  }

  TextEditingController searchPlaceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          autocorrect: true,
          placeholder: 'Buscar lugares...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.cancel_outlined),
          controller: searchPlaceController,
          onChanged: (String value) {
            searchPlaceController.text = value;
            mapProvider.goNewPosition(searchPlaceController.text);
            isSearchDirection = true;
          },
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
      body: HomeView(
        mapProvider: mapProvider,
        isSearchDirection: isSearchDirection!,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapProvider.getCurrentPosition();
        },
        child: FadeIn(child: const Icon(Icons.location_on_outlined)),
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
    SignInProvider signInProvider = context.watch<SignInProvider>();
    return TextButton(
      onPressed: () async {
        await signInProvider.singOut();
        context.go('/');
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cerrar sesión',
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

class HomeView extends StatefulWidget {
  final MapProvider mapProvider;
  final bool isSearchDirection;
  const HomeView({
    super.key,
    required this.mapProvider,
    required this.isSearchDirection,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    LatLng myPosition = widget.mapProvider.myPosition == null
        ? const LatLng(10.4093098, -75.4601968)
        : widget.isSearchDirection
            ? widget.mapProvider.placePosition!
            : widget.mapProvider.myPosition!;

    return FlutterMap(
      // mapController: mapControllerAnimation.mapController,
      options: MapOptions(
        center: myPosition,
        minZoom: 5,
        maxZoom: 25,
        zoom: 18,
        rotationWinGestures: MultiFingerGesture.none,
        // onMapReady: () {
        //   mapControllerAnimation.mapController.mapEventStream.listen(
        //     (evt) {
        //       myPosition = evt.center;
        //       setState(() {});
        //     },
        //   );
        //   // And any other `MapController` dependent non-movement methods
        // },
        // onPositionChanged: (newPosition, value) {
        //   if (newPosition.center != myPosition) {
        //     myPosition = newPosition.center!;
        //   }
        // },
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
        if (widget.mapProvider.myPosition != null ||
            widget.mapProvider.placePosition != null)
          MarkerLayer(
            markers: [
              Marker(
                point: myPosition,
                builder: (context) => FadeInRight(
                  child: Icon(
                    Icons.person_pin,
                    color: colors.primary,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
