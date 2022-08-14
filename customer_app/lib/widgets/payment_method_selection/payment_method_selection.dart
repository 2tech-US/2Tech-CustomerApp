import 'package:customer_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PaymentMethodSelectionWidget extends StatefulWidget {
  const PaymentMethodSelectionWidget({Key? key, required this.scaffoldState})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  State<PaymentMethodSelectionWidget> createState() =>
      _PaymentMethodSelectionWidgetState();
}

class _PaymentMethodSelectionWidgetState
    extends State<PaymentMethodSelectionWidget> {
  bool lookingForDriver = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
        builder: (BuildContext context, myscrollController) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.8),
                      offset: const Offset(3, 2),
                      blurRadius: 7)
                ]),
            child: ListView(
              controller: myscrollController,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Chọn hình thức thanh toán",
                    style: BaseTextStyle.fontFamilyBold(Colors.black, 20),
                  ),
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                                width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {
                              widget.scaffoldState.currentState!.showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Hình thức thanh toán này không khả dụng!")));
                            },
                            icon: const Icon(Icons.credit_card),
                            label: const Text("Bằng Thẻ")),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            border: Border.all(color: Colors.blue, width: 1.5)),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.monetization_on),
                            label: const Text("Bằng tiền mặt")),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                // appState.
                lookingForDriver
                    ? Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Container(
                          color: Colors.white,
                          child: const ListTile(
                            title: SpinKitWave(
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              // appState.requestDriver(
                              //     distance:
                              //         appState.routeModel.distance.toJson(),
                              //     user: userProvider.userModel,
                              //     lat: appState.pickupCoordinates.latitude,
                              //     lng: appState.pickupCoordinates.longitude,
                              //     context: context);
                              // appState.changeMainContext(context);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: SizedBox(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SpinKitWave(
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Đang tìm kiếm tài xế",
                                                    style: BaseTextStyle
                                                        .fontFamilyRegular(
                                                            Colors.black, 16),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              LinearPercentIndicator(
                                                lineHeight: 4,
                                                animation: true,
                                                animationDuration: 100000,
                                                percent: 1,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.2),
                                                progressColor:
                                                    Colors.deepOrange,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        // appState
                                                        //     .cancelRequest();
                                                        widget.scaffoldState
                                                            .currentState!
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Đã hủy tìm kiếm!")),
                                                        );
                                                      },
                                                      child: Text(
                                                        "Hủy tìm kiếm",
                                                        style: BaseTextStyle
                                                            .fontFamilyRegular(
                                                                Colors
                                                                    .deepOrange,
                                                                16),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            child: Text(
                              "Tìm kiếm tài xế",
                              style: BaseTextStyle.fontFamilyRegular(
                                  Colors.white, 16),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 10)
              ],
            ),
          );
        });
  }
}
