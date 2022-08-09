import 'package:customer_app/cubit/home/home_cubit.dart';
import 'package:customer_app/service/service_path.dart';
import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/widgets/pickup_selection/pickup_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class DestinationSelectionWidget extends StatefulWidget {
  const DestinationSelectionWidget({Key? key, required this.scaffoldState})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  State<DestinationSelectionWidget> createState() =>
      _DestinationSelectionWidgetState();
}

class _DestinationSelectionWidgetState
    extends State<DestinationSelectionWidget> {
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  TextEditingController destinationController = TextEditingController();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.8),
                  offset: const Offset(3, 2),
                  blurRadius: 7,
                )
              ]),
          child: ListView(
            controller: myscrollController,
            children: [
              const Icon(
                Icons.remove,
                size: 40,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  color: Colors.grey.withOpacity(.3),
                  child: TextField(
                    onTap: _onTapped,
                    textInputAction: TextInputAction.go,
                    controller: destinationController,
                    cursorColor: Colors.blue.shade900,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 15),
                        width: 10,
                        height: 10,
                        child: const Icon(
                          Icons.location_on,
                          color: BaseColor.primary,
                        ),
                      ),
                      hintText: "Bạn muốn đến đâu?",
                      hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                title: const Text("Home"),
                subtitle: const Text("102 QT, GV"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: const Icon(
                    Icons.work,
                    color: Colors.white,
                  ),
                ),
                title: Text("Work"),
                subtitle: Text("227 Nguyễn Văn Cừ, HCMC"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.18),
                  child: const Icon(
                    Icons.history,
                    color: BaseColor.primary,
                  ),
                ),
                title: const Text("Recent location"),
                subtitle: const Text("227 Nguyễn Văn Cừ, HCMC"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.18),
                  child: const Icon(
                    Icons.history,
                    color: BaseColor.primary,
                  ),
                ),
                title: const Text("Recent location"),
                subtitle: const Text("102 Quang Trung, HCMC"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onTapped() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: ServicePath.googleMapsAPIKey,
      mode: Mode.overlay,
      language: "vi",
      strictbounds: false,
      types: [""],
      onError: onError,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0.0,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: BaseColor.primary,
              width: 1.0,
            )),
        hintText: "Nhập địa chỉ",
        hintStyle: BaseTextStyle.fontFamilyRegular(Colors.black, 16),
      ),
      components: [Component(Component.country, "vn")],
    );

    await displayPrediction(p, scaffoldSate.currentState);
    BlocProvider.of<HomeCubit>(context).pickupSelection();

    // PlacesDetailsResponse detail =
    //     await places.getDetailsByPlaceId(p.placeId);
    // double lat = detail.result.geometry.location.lat;
    // double lng = detail.result.geometry.location.lng;
    // appState.changeRequestedDestination(
    //     reqDestination: p.description, lat: lat, lng: lng);
    // appState.updateDestination(destination: p.description);
    // LatLng coordinates = LatLng(lat, lng);
    // appState.setDestination(coordinates: coordinates);
    // appState.addPickupMarker(appState.center);
    // appState.changeWidgetShowed(
    //     showWidget: Show.PICKUP_SELECTION);
    // // appState.sendRequest(coordinates: coordinates);
  }

  void onError(PlacesAutocompleteResponse response) {
    scaffoldSate.currentState!
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction? p, ScaffoldState? scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: ServicePath.googleMapsAPIKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      addDestinationMarker(LatLng(lat, lng));

      scaffold!.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }

  void addDestinationMarker(LatLng position) {
    _markers.add(Marker(
      markerId: const MarkerId("destination"),
      position: position,
      anchor: const Offset(0, 0.85),
      zIndex: 3,
      infoWindow: const InfoWindow(title: "Điểm đến"),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}
