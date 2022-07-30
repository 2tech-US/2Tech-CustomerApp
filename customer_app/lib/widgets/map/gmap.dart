import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  const Gmap({Key? key, required this.scaffoldState}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController? _mapController;
  // GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.884250, 106.600420),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        mapType: MapType.normal,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('1'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(10.884250, 106.600420),
            infoWindow: InfoWindow(
              title: 'HCMUS',
              snippet: '102 Nguyễn Văn Cừ',
            ),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
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
