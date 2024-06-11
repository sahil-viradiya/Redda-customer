import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/model/nearby_place.dart';
import 'package:redda_customer/screens/home/home_controller.dart';
import 'package:redda_customer/widget/search_location_on_map_screen.dart';

import 'package:http/http.dart' as http;

class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen({super.key});

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  Rx<NearByPlaces> nearByPlaces = NearByPlaces().obs;
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  double? lat, lng;
  final HomeController homeController = Get.put(HomeController());

  //double? lat1,lng1;

  //RxDouble? lng=0.0.obs;
  String? address, city;
  LatLng needlePosition =
      const LatLng(0.0, 0.0); // Initial position for the "needle" marker.
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  RxString markerId = ''.obs;
  RxString liveAddress = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation(controller: homeController);
    setState(() {});
  }

  getUserCurrentLocation({required HomeController controller}) async {
    try {
      var status = await Permission.locationWhenInUse.request();

      if (status.isGranted) {
        homeController.status.value = "Status.granted";
      } else {
        homeController.status.value = "Please Enable Location Services";
      }
      setState(() {});
      print("location:-${status}");

      var accuracy = await Geolocator.getLocationAccuracy();
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      print("Permission ${PermissionStatus.granted}");

      if (status == PermissionStatus.granted) {
        if (isLocationServiceEnabled) {
          try {
            await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high)
                .then((value) async {
              final GoogleMapController controller = await mapController.future;

              setState(() {
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 17)));
                markers.add(Marker(
                    markerId: const MarkerId("newLocation"),
                    position: LatLng(value.latitude, value.longitude)));
                lat = value.latitude;
                lng = value.longitude;

                needlePosition = LatLng(
                    lat!, lng!); // Initial position for the "needle" marker.

                print('latititue${lat}');
                print('longitude${lng}');
                getNearByLocations();
                getAddressFromLatLong(
                    latitude: lat!,
                    longitude: lng!,
                    controller: homeController);
              });
            });
          } catch (e) {
            print(e.toString());
          }
        } else {
          Fluttertoast.showToast(msg: "You need to allow location Service");
        }
      } else {
        Fluttertoast.showToast(
            msg: "You need to allow location permission in order to continue");
      }
    } catch (e) {
      debugPrint("getUserCurrentLocation:-$e");
    }
  }

  getNearByLocations() async {
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng" +
            "&radius=100&key=${Config.apiKey}";
    print('url:$url');
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      nearByPlaces.value = NearByPlaces.fromJson(jsonDecode(response.body));
    } else {
      Fluttertoast.showToast(
          msg: "Something Went wrong in Get near by function");
    }
  }

  //Future<void> getAddressFromLatLong(Position position) async {
  Future<void> getAddressFromLatLong(
      {required double latitude,
      required double longitude,
      required HomeController controller}) async {
    print("latitude=============>:-${latitude}");
    print("longitude==============>:-${longitude}");
    latlng.value = LatLng(latitude, longitude);
    //markerId.value = position.timestamp.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    liveAddress.value = "";
    liveAddress.value =
        '${place.locality}, ${place.administrativeArea}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}, ${place.thoroughfare}, ${place.subThoroughfare}';
    setState(() {
      homeController.currentLocation.value = liveAddress.value;
    });
    print('liveAddress:- ${liveAddress.value}');
    //if(liveAddress.isNotEmpty && liveAddress.value != ""){
    // Get.back(result: ['', liveAddress.value]);
    // }else{
    //   print('Something wrong');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      buildingsEnabled: true,
      liteModeEnabled: false,
      // Make sure liteModeEnabled is set to false
      rotateGesturesEnabled: true,
      zoomGesturesEnabled: true,
      webGestureHandling: WebGestureHandling.greedy,
      // This is for web platforms
      scrollGesturesEnabled: true,
      // Enable scroll gestures
      tiltGesturesEnabled: true,
      // Enable tilt gestures if needed
      /// If you comment this below line your
      onMapCreated: onMapCreated,

      onTap: _handleMapTap,
      // Listen for map taps.
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },

      zoomControlsEnabled: false,

      initialCameraPosition:
          const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),

      /// if you uncomment below marker and comment the current markers then user cant be seelcted location on map
      //markers: markers,
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('needleNew'),
          position: needlePosition, // Use the updated position here.
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      },
    );
    //   Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     leading: InkWell(
    //         onTap: () {
    //           Get.back();
    //         },
    //         child: const Icon(
    //           Icons.arrow_back,
    //           color: Colors.black,
    //         )),
    //     elevation: 0.0,
    //     title: const Text(
    //       "Get Current Location",
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: selectLocationOnMap,
    //         icon: const Icon(Icons.search, color: Colors.black),
    //       ),
    //       IconButton(
    //         onPressed: () {
    //           getUserCurrentLocation();
    //           nearByPlaces.value = NearByPlaces();
    //         },
    //         icon: const Icon(Icons.refresh, color: Colors.black),
    //       ),
    //     ],
    //   ),
    //   body:
    // );
  }

  void _handleMapTap(LatLng tappedPoint) {
    setState(() {
      // Update the marker's position to the tapped point.
      lat = tappedPoint.latitude;
      lng = tappedPoint.longitude;
      needlePosition = tappedPoint;
      print('Lat:$lat');
      print('Lng:$lng');
    });
  }

  void selectLocationOnMap() async {
    var result = await Get.to(() => const SearchLocationOnMapScreen());
    if (result != null) {
      getAddressFromLatLong(
          latitude: result[1],
          longitude: result[2],
          controller: homeController);
      //Get.back(result: ['', result[1], result[2]]);
      debugPrint("Selected " + result.toString());
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController.complete(controller);
    });
  }
}
