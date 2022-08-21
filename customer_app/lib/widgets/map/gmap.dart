import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
  TextEditingController destinationController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      CameraPosition myCurrentLocation = CameraPosition(
        target: LatLng(newLoc.latitude!, newLoc.longitude!),
        zoom: 14.4746,
      );
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(myCurrentLocation));
      setState(() {});
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 14.4746,
        ),
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
          getCurrentLocation();
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
