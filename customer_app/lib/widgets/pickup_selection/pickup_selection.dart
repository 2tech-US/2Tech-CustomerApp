import 'package:customer_app/service/service_path.dart';
import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/destination_selection/destination_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class PickupSelectionWidget extends StatefulWidget {
  const PickupSelectionWidget({Key? key, required this.scaffoldState})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldState;
  @override
  State<PickupSelectionWidget> createState() => _PickupSelectionWidgetState();
}

class _PickupSelectionWidgetState extends State<PickupSelectionWidget> {
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  TextEditingController pickupLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
    pickupLocationController.text = 'Pickup Location';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.28,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(color: Colors.white,
//                        borderRadius: BorderRadius.only(
//                            topLeft: Radius.circular(20),
//                            topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.8),
                    offset: const Offset(3, 2),
                    blurRadius: 7)
              ]),
          child: ListView(controller: myscrollController, children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Xác nhận vị trí đón",
                  style: BaseTextStyle.fontFamilyMedium(Colors.black, 16),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Container(
                color: Colors.grey.withOpacity(.3),
                child: TextField(
                  onTap: _onTapped,
                  readOnly: true,
                  textInputAction: TextInputAction.go,
                  controller: pickupLocationController,
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
                    hintText: "Địa điểm đón",
                    hintStyle:
                        BaseTextStyle.fontFamilyRegular(Colors.black, 18),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: CustomButton.common(
                  onTap: () {},
                  content: "Xác nhận điểm đón",
                ),
              ),
            ),
          ]),
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
    displayPrediction(p, scaffoldSate.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    scaffoldSate.currentState!
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<Null> displayPrediction(Prediction? p, ScaffoldState? scaffold) async {
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

      scaffold!.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }
}