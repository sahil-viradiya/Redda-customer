import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redda_customer/constant/api_key.dart';

class LocationController extends GetxController {
  var status = ''.obs;
  var currerntLat = 0.0.obs;
  var currerntLng = 0.0.obs;
  var currentLocation = ''.obs;

  Future<void> getUserCurrentLocation() async {
    try {
      if (await _requestLocationPermission()) {
        if (await Geolocator.isLocationServiceEnabled()) {
          await _fetchCurrentLocation();
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

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
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
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currerntLat.value = position.latitude;
      currerntLng.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      log("current full location----> $placemarks");

      await _fetchAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
  }

  Future<void> _fetchAddressFromCoordinates(double latitude, double longitude) async {
    final apiKey = Config.apiKey; // Replace with your Google Maps API key
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
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
              Fluttertoast.showToast(msg: "No address found for the provided coordinates");
            }
          } else {
            Fluttertoast.showToast(msg: "Geocoding failed: ${jsonResponse['status']}");
          }
        } else {
          Fluttertoast.showToast(msg: "HTTP request failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
