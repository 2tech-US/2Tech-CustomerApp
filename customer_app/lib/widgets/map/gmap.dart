import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  const Gmap({
    Key? key,
    required this.scaffoldState,
    this.marker,
    this.polylineCoordinates,
    required this.onMapCreated,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;
  final Marker? marker;
  final List<LatLng>? polylineCoordinates;
  final MapCreatedCallback onMapCreated;

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  late GoogleMapController _mapController;
  late Position currentPosition;
  TextEditingController destinationController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CameraPosition myCurrentLocation = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14.4746,
    );
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(myCurrentLocation));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: {widget.marker!},
        compassEnabled: true,
        zoomGesturesEnabled: true,
        rotateGesturesEnabled: true,
        polylines: widget.polylineCoordinates != null
            ? {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: widget.polylineCoordinates!,
                  color: Colors.purple,
                  width: 6,
                )
              }
            : {},
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _determinePosition();
          widget.onMapCreated(controller);
        },
      ),
      Positioned(
        top: 10,
        left: 15,
        child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: BaseColor.primary,
              size: 30,
            ),
            onPressed: () {
              scaffoldSate.currentState!.openDrawer();
            }),
      ),
    ]);
  }
}
