import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class LocationController extends GetxController {
  var status = ''.obs;
  var currerntLat = 0.0.obs;
  var currerntLng = 0.0.obs;
  var currentLocation = ''.obs;
  var isConnected = false.obs;
  var isLocationServiceEnabled = false.obs;

  final Connectivity _connectivity = Connectivity();
  Rx<Key> locationWidgetKey = UniqueKey().obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkLocationServiceStatus();
    ever(isLocationServiceEnabled, (_) => fetchLocationDetails());
    ever(isLocationServiceEnabled, (_) => rebuildLocationWidget());
  }

  void rebuildLocationWidget() => locationWidgetKey.value = UniqueKey();

  void _checkLocationServiceStatus() async {
    isLocationServiceEnabled.value =
        await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((status) {
      isLocationServiceEnabled.value = (status == ServiceStatus.enabled);
    });
  }

  Future<void> fetchLocationDetails() async {
    if (!await _requestLocationPermission()) {
      Fluttertoast.showToast(
        msg: "You need to allow location permission to continue",
      );
      return;
    }

    if (!isLocationServiceEnabled.value) {
      Fluttertoast.showToast(
        msg: "You need to allow location Service",
      );
      return;
    }

    await _fetchCurrentLocation();
  }

  Future<bool> _requestLocationPermission() async {
    var status = await perm.Permission.locationWhenInUse.request();
    this.status.value =
        status.isGranted ? "Status.granted" : "Please Enable Location Services";
    return status.isGranted;
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currerntLat.value = position.latitude;
      currerntLng.value = position.longitude;
      await _fetchAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  Future<void> _fetchAddressFromCoordinates(
      double latitude, double longitude) async {
    final apiKey = Config.apiKey;
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status'] == 'OK' &&
              jsonResponse['results'].isNotEmpty) {
            currentLocation.value =
                jsonResponse['results'][0]['formatted_address'];
            print('liveAddress: ${currentLocation.value}');
            rebuildLocationWidget();
            return;
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
    Fluttertoast.showToast(msg: "Failed to fetch address");
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    isConnected.value = (result != ConnectivityResult.none);
    if (isConnected.value) fetchLocationDetails();
  }
}
