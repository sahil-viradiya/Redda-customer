import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/constant/app_color.dart';

import '../constant/app_image.dart';
import '../constant/style.dart';
import '../route/app_route.dart';
import '../screens/Pick Up Location/address_details/address_details_controller.dart';
import '../screens/Pick Up Location/address_details/address_details_screen.dart';
import '../screens/address_details_screen/enter_new_address_details.dart';
import 'auth_app_bar_widget.dart';
import 'custom_button.dart';

class SearchLocationOnMapForDropScreen extends StatefulWidget {
  const SearchLocationOnMapForDropScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationOnMapForDropScreen> createState() =>
      _SearchLocationOnMapForDropScreenState();
}

class _SearchLocationOnMapForDropScreenState
    extends State<SearchLocationOnMapForDropScreen> {
  Completer<GoogleMapController> mapController = Completer();

  Set<Marker> markers = {};
  double? lat, lng;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String address = '';
  String cityName = '';

  @override
  void initState() {
    super.initState();
    getUserCurrentLocation();
  }

  void getUserCurrentLocation() async {
    var status = await Permission.location.request();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (status == PermissionStatus.granted) {
      if (isLocationServiceEnabled) {
        await Geolocator.getCurrentPosition().then((value) async {
          final GoogleMapController controller = await mapController.future;
          setState(() {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 17)));
            markers.add(Marker(
                markerId: const MarkerId("newLocation"),
                position: LatLng(value.latitude, value.longitude)));
            address = address;
            lat = value.latitude;
            lng = value.longitude;
          });
          await getAddress();
        });
      } else {
        Fluttertoast.showToast(msg: "You need to allow location Service");
      }
    } else {
      Fluttertoast.showToast(
          msg: "You need to allow location permission in order to continue");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Set Drop Location",
      ),
      key: homeScaffoldKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            compassEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: onMapCreated,
            initialCameraPosition:
                const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: markers,
            onTap: (LatLng pos) {
              setState(() {
                lat = pos.latitude;
                lng = pos.longitude;
                markers.add(Marker(
                    markerId: const MarkerId("newLocation"), position: pos));
              });
            },
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            // height: 120,

            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppImage.LOCATION2),
                    const Gap(6),
                    Expanded(
                      child: Text(
                        cityName.isNotEmpty ? cityName : "Fetching...",
                        style: Styles.boldBlack612,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _handlePressButton();
                      },
                      child: Text(
                        "Change",
                        style: Styles.boldBlue612,
                      ),
                    ),
                  ],
                ),
                Text(
                  address.toString(),
                  style: Styles.lable414,
                ),
                const Gap(12),
                CustomButton(
                  width: Get.width,
                  height: 35,
                  borderCircular: 6,
                  text: "Confirm Location",
                  fun: lat!=null? () async {
                    await getAddress();
                    Get.toNamed(AppRoutes.DROPADDRESSDETAILS,
                        arguments: [lat.toString(), lng.toString()]);
                  }:(){},
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 10),
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: primary,
                    textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: getUserCurrentLocation,
                  child: const Icon(Icons.my_location_rounded,
                      color: Colors.white),
                ),
              ),
            ),
          ),

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 60, left: 8, right: 8),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.blue,
          //           textStyle: const TextStyle(
          //               color: Colors.green,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         onPressed: _handlePressButton,
          //         child: const Text("Search"),
          //       ),
          //     ),
          //   ),
          // ),

          //=========================================
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width,
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: primary,
          //           textStyle: const TextStyle(
          //               color: red, fontSize: 16, fontWeight: FontWeight.w500),
          //         ),
          //         onPressed: getAddress,
          //         child: const Text("Confirm"),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController.complete(controller);
    });
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Config.apiKey!,
      onError: onError,
      mode: Mode.overlay,
      language: "en-us",
      types: [""],
      strictbounds: false,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [
        Component(Component.country, "pk"),
        Component(Component.country, "in")
      ],
    );
    displayPrediction(p!, homeScaffoldKey.currentState!);
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Config.apiKey!,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId.toString());
    lat = detail.result.geometry!.location.lat;
    lng = detail.result.geometry!.location.lng;
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat!, lng!), zoom: 17)));
    setState(() {
      markers.add(Marker(
          markerId: const MarkerId("newLocation"),
          position: LatLng(lat!, lng!)));
    });
    await getAddress();
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  getAddress() async {
    GeoData fetchGeocoder = await Geocoder2.getDataFromCoordinates(
        latitude: lat!, longitude: lng!, googleMapApiKey: Config.apiKey!);
    setState(() {
      address = fetchGeocoder.address;
      cityName = extractCity(fetchGeocoder.address);
      print("==========add========${fetchGeocoder.address}");
    });
    // Get.back(result: [fetchGeocoder.address]);
    // Get.back(result: [fetchGeocoder.address, lat.toString(), lng.toString()]);
  }

  String extractCity(String fullAddress) {
    List<String> addressParts = fullAddress.split(',');
    if (addressParts.length >= 2) {
      return addressParts[addressParts.length - 3].trim();
    }
    return "Unknown";
  }
}
