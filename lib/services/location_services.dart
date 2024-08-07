import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:permission_handler/permission_handler.dart'
    as perm; // Add prefix

class LocationController extends GetxController {
  var status = ''.obs;
  var currerntLat = 0.0.obs;
  var currerntLng = 0.0.obs;
  var currentLocation = ''.obs;
  var isConnected = false.obs;
  var isLocationServiceEnabled = false.obs; // Reactive variable

  final Connectivity _connectivity = Connectivity();
  Rx<Key> locationWidgetKey = UniqueKey().obs; // Key to rebuild the widget

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkLocationServiceStatus(); // Initial call
    ever(isLocationServiceEnabled,
        (_) => fetchLocationDetails()); // Reactively call location fetching
    ever(isLocationServiceEnabled, (_) => rebuildLocationWidget());
    fetchLocationDetails(); // Initial call
  }

  void rebuildLocationWidget() {
    locationWidgetKey.value = UniqueKey(); // Assign a new key to force rebuild
  }

  void _checkLocationServiceStatus() async {
    isLocationServiceEnabled.value =
        await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((status) {
      isLocationServiceEnabled.value = (status == ServiceStatus.enabled);
    });
  }

  Future<void> fetchLocationDetails() async {
    try {
      if (await _requestLocationPermission()) {
        if (await Geolocator.isLocationServiceEnabled()) {
          await _fetchCurrentLocation();
        } else {
          Fluttertoast.showToast(msg: "You need to allow location Service");
        }
      } else {
        Fluttertoast.showToast(
            msg: "You need to allow location permission in order to continue");
      }
    } catch (e) {
      debugPrint("fetchLocationDetails:-$e");
    }
  }

  Future<bool> _requestLocationPermission() async {
    var status =
        await perm.Permission.locationWhenInUse.request(); // Use prefix
    if (status.isGranted) {
      this.status.value = "Status.granted";
      return true;
    } else {
      this.status.value = "Please Enable Location Services";
      return false;
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currerntLat.value = position.latitude;
      currerntLng.value = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      log("current full location----> $placemarks");

      await _fetchAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  Future<void> _fetchAddressFromCoordinates(
      double latitude, double longitude) async {
    final apiKey = Config.apiKey; // Replace with your Google Maps API key
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    int retries = 3;
    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status'] == 'OK') {
            final results = jsonResponse['results'];
            if (results.isNotEmpty) {
              final address = results[0]['formatted_address'];
              currentLocation.value = address;
              print('liveAddress:- ${currentLocation.value}');
              return;
            } else {
              Fluttertoast.showToast(
                  msg: "No address found for the provided coordinates");
            }
          } else {
            Fluttertoast.showToast(
                msg: "Geocoding failed: ${jsonResponse['status']}");
          }
        } else {
          Fluttertoast.showToast(
              msg: "HTTP request failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    isConnected.value = (result != ConnectivityResult.none);
    if (isConnected.value) {
      // Try to fetch location again when connected
      fetchLocationDetails();
    }
  }
}
