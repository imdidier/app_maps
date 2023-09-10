import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapProvider mapProvider;
  late SignInProvider signInProvider;
  bool isSearchDirection = false;
  @override
  void didChangeDependencies() {
    mapProvider = Provider.of<MapProvider>(context);
    signInProvider = Provider.of<SignInProvider>(context);
    super.didChangeDependencies();
  }

  TextEditingController searchPlaceController = TextEditingController();

  @override
  void dispose() {
    searchPlaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapas'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => isSearchDirection = !isSearchDirection);
            },
            icon: Icon(
              isSearchDirection
                  ? Icons.expand_less_outlined
                  : Icons.search_outlined,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          HomeView(
            mapProvider: mapProvider,
          ),
          _buildSearchLocation(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isSearchDirection = false;
          mapProvider.getCurrentPosition();
        },
        child: FadeIn(child: const Icon(Icons.location_on_outlined)),
      ),
    );
  }

  Visibility _buildSearchLocation() {
    return Visibility(
      visible: isSearchDirection,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 10),
            child: SlideInDown(
              child: _buildSearchBar(),
            ),
          ),
          if (mapProvider.addressList.isNotEmpty) _buildSearchResult(),
        ],
      ),
    );
  }

  Padding _buildSearchResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 10),
      child: SlideInDown(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: mapProvider.addressList.length == 1
              ? 50
              : mapProvider.addressList.length > 3
                  ? 240
                  : 120,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mapProvider.addressList.length,
            itemBuilder: ((context, index) {
              Map<String, dynamic> address = mapProvider.addressList[index];

              return ListTile(
                title: Text(
                  '${address['formatted_address']}',
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                onTap: () async {
                  isSearchDirection = false;
                  mapProvider.goNewPosition(address['geometry']['location']);
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  SearchBar _buildSearchBar() {
    return SearchBar(
      controller: searchPlaceController,
      leading: GestureDetector(
        onTap: () => setState(() {
          searchPlaceController.clear();
          mapProvider.addressList.clear();
        }),
        child: const Icon(Icons.cancel),
      ),
      hintText: 'Buscar...',
      constraints: const BoxConstraints(minHeight: 40),
      trailing: [
        IconButton(
          onPressed: () {
            mapProvider.searchAddress(searchPlaceController.text);
            setState(() {});
          },
          icon: const Icon(Icons.search_outlined),
        )
      ],
      onSubmitted: (value) {
        mapProvider.searchAddress(value);
        setState(() {});
      },
    );
  }
}

class HomeView extends StatefulWidget {
  final MapProvider mapProvider;
  const HomeView({
    super.key,
    required this.mapProvider,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const initialPosition = LatLng(10.4093098, -75.4601968);

    Marker marker = Marker(
      markerId: const MarkerId('My house'),
      infoWindow: const InfoWindow(title: 'My house'),
      icon: BitmapDescriptor.defaultMarker,
      position: widget.mapProvider.myPosition ??
          widget.mapProvider.placePosition ??
          initialPosition,
    );

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: initialPosition,
        zoom: 15,
      ),
      mapToolbarEnabled: false,
      markers: {marker},
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController mapController) {
        widget.mapProvider.mapController = mapController;
      },
    );
  }
}
