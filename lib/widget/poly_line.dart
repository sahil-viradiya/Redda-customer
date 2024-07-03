import 'dart:developer';

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
import 'package:redda_customer/screens/Drop%20Location/pick_or_send_any/pick_or_send_any_controller.dart';
import 'package:redda_customer/screens/home/home_controller.dart';
import 'package:redda_customer/widget/search_location_on_map_screen.dart';
import 'package:http/http.dart' as http;


class GetLocationPolyLineScreen extends StatefulWidget {
   const GetLocationPolyLineScreen({super.key,required this.dropLat,required this.dropLng,required this.pickLat,required this.pickLng});
   final  dropLat;
   final  dropLng;
   final  pickLat;
   final  pickLng;

  @override
  State<GetLocationPolyLineScreen> createState() => _GetLocationPolyLineScreenState();
}

  final PickOrSendAnyController pickupController = Get.put(PickOrSendAnyController());
class _GetLocationPolyLineScreenState extends State<GetLocationPolyLineScreen> {
  Rx<NearByPlaces> nearByPlaces = NearByPlaces().obs;
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  double? lat, lng;
  final HomeController homeController = Get.put(HomeController());

  String? address, city;
  LatLng needlePosition = const LatLng(0.0, 0.0);
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  RxString markerId = ''.obs;
  RxString liveAddress = ''.obs;
var icon;
  // Static pickup and drop locations
  late LatLng dropLocation;
  late LatLng pickupLocation;

  @override
  void initState() {
    super.initState();
    getIcons();
    // getUserCurrentLocation(controller: homeController);
    log("latttttttttttddttttttttt ${widget.dropLat.runtimeType}");
    log("latttttttttttttttttttt ${widget.pickLng.runtimeType}");
    pickupLocation = LatLng(widget.pickLat is double ? widget.pickLat : double.parse(widget.pickLat.toString()),
        widget.pickLng is double ? widget.pickLng : double.parse(widget.pickLng.toString()));
    dropLocation = LatLng(widget.dropLat is double ? widget.dropLat : double.parse(widget.dropLat.toString()),
        widget.dropLng is double ? widget.dropLng : double.parse(widget.dropLng.toString()));
     }
  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 3),
        "assets/images/png/location-marker.png");
    setState(() {
      this.icon = icon;
      

    });
    setMarkersAndPolyline();

  }

  void setMarkersAndPolyline() async {
    markers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: dropLocation,
      icon: icon,

      infoWindow: const InfoWindow(title: 'Pickup Location'),
    ));
    markers.add(Marker(
      markerId: const MarkerId('drop'),
      icon: icon,
      position: pickupLocation,
      infoWindow: const InfoWindow(title: 'Drop Location'),
    ));

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation.latitude},${pickupLocation.longitude}&destination=${dropLocation.latitude},${dropLocation.longitude}&key=${Config.apiKey}";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      List<LatLng> polylineCoordinates = decodePolyline(data['routes'][0]['overview_polyline']['points']);

      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: polylineCoordinates,
        startCap: Cap.buttCap,
        color: primary,
        jointType: JointType.round,

        patterns: [PatternItem.dot, PatternItem.gap(10)],

        width: 5,
      ));

      // Adjust the camera position to fit the polyline
      final GoogleMapController controller = await mapController.future;
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          (pickupLocation.latitude < dropLocation.latitude) ? pickupLocation.latitude : dropLocation.latitude,
          (pickupLocation.longitude < dropLocation.longitude) ? pickupLocation.longitude : dropLocation.longitude,
        ),
        northeast: LatLng(
          (pickupLocation.latitude > dropLocation.latitude) ? pickupLocation.latitude : dropLocation.latitude,
          (pickupLocation.longitude > dropLocation.longitude) ? pickupLocation.longitude : dropLocation.longitude,
        ),
      );
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      Fluttertoast.showToast(msg: "Failed to get route");
    }

    setState(() {});
  }

  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return points;
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
      print("location:-$status");

      var accuracy = await Geolocator.getLocationAccuracy();
      bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

      print("Permission ${PermissionStatus.granted}");

      if (status == PermissionStatus.granted) {
        if (isLocationServiceEnabled) {
          try {
            await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) async {
              final GoogleMapController controller = await mapController.future;

              setState(() {
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 17)));
                lat = value.latitude;
                lng = value.longitude;

                needlePosition = LatLng(lat!, lng!);

                print('latitude: $lat');
                print('longitude: $lng');
                getNearByLocations();
                getAddressFromLatLong(latitude: lat!, longitude: lng!, controller: homeController);
              });
            });
          } catch (e) {
            print(e.toString());
          }
        } else {
          Fluttertoast.showToast(msg: "You need to allow location Service");
        }
      } else {
        Fluttertoast.showToast(msg: "You need to allow location permission in order to continue");
      }
    } catch (e) {
      debugPrint("getUserCurrentLocation:-$e");
    }
  }

  getNearByLocations() async {
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng" "&radius=100&key=${Config.apiKey}";
    print('url:$url');
    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      nearByPlaces.value = NearByPlaces.fromJson(jsonDecode(response.body));
    } else {
      Fluttertoast.showToast(msg: "Something Went wrong in Get near by function");
    }
  }

  Future<void> getAddressFromLatLong(
      {required double latitude,
        required double longitude,
        required HomeController controller}) async {
    print("latitude=============>:-$latitude");
    print("longitude==============>:-$longitude");
    latlng.value = LatLng(latitude, longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    liveAddress.value = "";
    liveAddress.value =
    '${place.locality}, ${place.administrativeArea}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}, ${place.thoroughfare}, ${place.subThoroughfare}';
    setState(() {
      homeController.currentLocation.value = liveAddress.value;
    });
    print('liveAddress:- ${liveAddress.value}');
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
      rotateGesturesEnabled: true,
      zoomGesturesEnabled: true,
      webGestureHandling: WebGestureHandling.greedy,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      onMapCreated: onMapCreated,
      onTap: _handleMapTap,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer(),),
      },
      zoomControlsEnabled: false,
      initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),
      markers: markers,

      polylines: polylines,
    );
  }

  void _handleMapTap(LatLng tappedPoint) {
    setState(() {
      lat = tappedPoint.latitude;
      lng = tappedPoint.longitude;
      needlePosition = tappedPoint;
      // Clear existing markers if any
      markers.clear();
      // Adding a new marker at the tapped point (if needed)
      markers.add(Marker(
        markerId: const MarkerId('tappedLocation'),
        position: tappedPoint,
        icon: icon
      ));
      print('Lat: $lat');
      print('Lng: $lng');
      // Add a polyline from the user's current location to the tapped location
      if (lat != null && lng != null) {
        polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: [LatLng(lat!, lng!), tappedPoint],
          color: Colors.blue,
          width: 5,
        ));
      }
    });
  }

  void selectLocationOnMap() async {
    var result = await Get.to(() => const SearchLocationOnMapScreen());
    if (result != null) {
      getAddressFromLatLong(latitude: result[1], longitude: result[2], controller: homeController);
      debugPrint("Selected $result");
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController.complete(controller);
    });
  }
}


class DistanceCalculator {
  static const double averageSpeedKmPerHour = 20.0; // Average speed in km/h

  static double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng) / 1000; // Distance in km
  }

  static String estimateTime(double distance) {
    final double timeInHours = distance / averageSpeedKmPerHour;
    final int minutes = (timeInHours * 60).round();
    final Duration duration = Duration(minutes: minutes);

    // Format duration as hours and minutes
    final String formattedDuration = _formatDuration(duration);
    return formattedDuration;
  }

  static String _formatDuration(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final List<String> parts = [];

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? "hour" : "hours"}');
    }
    if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? "minute" : "minutes"}');
    }

    return parts.join(' ');
  }
}