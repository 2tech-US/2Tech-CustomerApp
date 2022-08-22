import 'package:customer_app/cubit/app_cubit.dart';
import 'package:customer_app/cubit/home/home_cubit.dart';
import 'package:customer_app/models/notification/notification_model.dart';
import 'package:customer_app/utils/base_constant.dart';
import 'package:customer_app/widgets/destination_selection/destination_selection.dart';
import 'package:customer_app/widgets/notification/notification_badge.dart';
import 'package:customer_app/widgets/payment_method_selection/payment_method_selection.dart';
import 'package:customer_app/widgets/pickup_selection/pickup_selection.dart';
import 'package:customer_app/widgets/template_page/app_loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/widgets/map/gmap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldState = GlobalKey<ScaffoldState>();
  Marker mark = const Marker(markerId: MarkerId("destination"));
  List<LatLng> polylinePoints = [];
  late GoogleMapController mapController;
  late int _totalNotifications;
  NotificationModel? _notificationInfor;
  LatLng? destinationLocation;
  LatLng? pickupLocation;

  void requestAndRegisterNotification() async {
    // For handling the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Parse the message received
      NotificationModel notification = NotificationModel(
        title: message.notification?.title,
        body: message.notification?.body,
        data: message.data,
      );
      print('Notification data: ${notification.data!['phone']}');

      setState(() {
        _notificationInfor = notification;
        _totalNotifications++;
      });
      if (_notificationInfor != null) {
        // For displaying the notification as an overlay
        showSimpleNotification(
          Text(_notificationInfor!.title!,
              style: BaseTextStyle.fontFamilyMedium(Colors.black, 20)),
          leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Text(
            _notificationInfor!.body!,
            style: BaseTextStyle.fontFamilyRegular(Colors.black, 18),
          ),
          background: BaseColor.hint,
          contentPadding: const EdgeInsets.all(6),
          duration: const Duration(seconds: 5),
        );
      }
    });
  }

  @override
  void initState() {
    requestAndRegisterNotification();
    _totalNotifications = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, CubitState>(
      builder: (context, appState) {
        if (appState is AuthenticatedState) {
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, homeState) {
                return SafeArea(
                    child: Scaffold(
                  key: scaffoldState,
                  drawer: Drawer(
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 231, 175, 92),
                            ),
                            currentAccountPicture: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png')),
                            accountName: Text(
                              appState.user.name,
                              style: BaseTextStyle.fontFamilyBold(
                                  Colors.black, 18),
                            ),
                            accountEmail: Text(
                              "SĐT: ${appState.user.phone}",
                              style: BaseTextStyle.fontFamilyRegular(
                                  Colors.black, 17),
                            )),
                        ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: const Text("Đăng xuất"),
                          onTap: () {
                            BlocProvider.of<AppCubit>(context).logout();
                          },
                        )
                      ],
                    ),
                  ),
                  body: Stack(children: <Widget>[
                    Gmap(
                      scaffoldState: scaffoldState,
                      marker: mark,
                      polylineCoordinates: polylinePoints,
                      onMapCreated: (controller) => mapController = controller,
                    ),
                    Visibility(
                      visible: true,
                      child: Positioned(
                          top: 60,
                          left: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: _notificationInfor != null
                                      ? Container(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              "Meet driver at the pick up location",
                                              style: BaseTextStyle
                                                  .fontFamilyMedium(
                                                      Colors.white, 18),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible: homeState is DestinationSelectState,
                      child: DestinationSelectionWidget(
                        scaffoldState: scaffoldState,
                        callBack: (marker, polyPoints, destination) {
                          setState(() {
                            mark = marker;
                            polylinePoints = polyPoints;
                            destinationLocation = destination;
                          });
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                            target: mark.position,
                            zoom: 10.5,
                          )));
                          mapController.showMarkerInfoWindow(mark.markerId);
                        },
                      ),
                    ),
                    Visibility(
                      visible: homeState is PickupSeletionState,
                      child: PickupSelectionWidget(
                        scaffoldState: scaffoldState,
                        callBack: (pickupLoc) {
                          setState(() {
                            pickupLocation = pickupLoc;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: homeState is PaymentSeletionState,
                      child: PaymentMethodSelectionWidget(
                        scaffoldState: scaffoldState,
                      ),
                    ),
                  ]),
                ));
              },
            ),
          );
        }
        return const AppLoadingPage();
      },
    );
  }
}
