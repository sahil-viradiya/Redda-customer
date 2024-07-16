import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constant/app_image.dart';
import '../auth/signIn/signIn_controller.dart';

RxString name = ''.obs;

class HomeController extends GetxController {
  final count = 0.obs;
  final currentIndex = 0.obs;
  final List? items = [AppImage.SLIDE, AppImage.SLIDE, AppImage.SLIDE];
  var status = ''.obs;
  
  RxString currentLocation = ''.obs;
  
  
  RxDouble currerntLat = 0.0.obs;
  RxDouble currerntLng = 0.0.obs;
  final CarouselController slideController = CarouselController();
  Rx<Key> locationWidgetKey = UniqueKey().obs; // Key to rebuild the widget

  void rebuildLocationWidget() {
    locationWidgetKey.value = UniqueKey(); // Assign a new key to force rebuild
  }

  final SignInController signInController = Get.put(SignInController());

  @override
  void onInit() {
    getUserCurrentLocation();
    try {
      signInController.loadUserData().then((val) {
        if (val != null) {
          name.value = val;
        }
      });
    } catch (error) {
      log("Error occurred while loading user data: $error");
    } finally {
      update();
      super.onInit();
    }
  }

  getUserCurrentLocation() async {
    try {
      var status1 = await Permission.locationWhenInUse.request();

      if (status1.isGranted) {
        status.value = "Status.granted";
      } else {
        status.value = "Please Enable Location Services";
      }

      print("location:-$status");

      var accuracy = await Geolocator.getLocationAccuracy();
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      print("Permission ${PermissionStatus.granted}");

      if (status1 == PermissionStatus.granted) {
        if (isLocationServiceEnabled) {
          try {
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            print(
                "lat:-${position.latitude} lng:-${position.longitude}");
            currerntLat.value = position.latitude;
            currerntLng.value= position.longitude;
            update();
            refresh();
            List<Placemark> placemarks = await placemarkFromCoordinates(
                position.latitude, position.longitude);
                log("current full location----> $placemarks");

            print(placemarks[0].locality);
            print(placemarks[0].street);
            print(placemarks[0].subLocality);
            print(placemarks[0].subAdministrativeArea);
            print(placemarks[0].administrativeArea);
            print(placemarks[0].postalCode);
            print(placemarks[0].country);
            print(placemarks[0].name);
            currentLocation.value = '${placemarks[0].street!},${placemarks[0].name},${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].postalCode}';
            rebuildLocationWidget();
            print("currentLocation:-$currentLocation");
            update();
            
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

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
