import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/location_sugetion.dart';
import 'package:redda_customer/widget/search_location_on_map_screen.dart';

import '../../../Utils/network_client.dart';

class SetPickUpLocationController extends GetxController {
  final count = 0.obs;
  Rx<String> liveAddress = ''.obs;
  RxDouble selectedPlaceLat = 0.0.obs;
  RxDouble selectedPlaceLng = 0.0.obs;
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  var selectedLocation = ''.obs;

  final TextEditingController locationController = TextEditingController();
  final PlacesService placesService = PlacesService();
  RxList<dynamic> suggestions = <dynamic>[].obs;

  void onSearchChanged() async {
    if (locationController.text.isEmpty) {
      suggestions.clear();
      update();
      return;
    }

    final fetchedSuggestions =
        await placesService.getPlaceSuggestions(locationController.text);
    suggestions.assignAll(fetchedSuggestions);
    log("====================Location List========================$suggestions");
    update();
  }

  @override
  void onReady() {}

  Future<dynamic> getLatLong(String placeId) async {
    try {
      var response = await dioClient.get(
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${placesService.apiKey}");
      selectedPlaceLat.value = double.parse(
          response['result']['geometry']['location']['lat'].toString());
      selectedPlaceLng.value = double.parse(
          response['result']['geometry']['location']['lng'].toString());
      log("lat long=selected====>   ${selectedPlaceLat.value.toDouble()}");
      // final String url =
      //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?place_id=$placeId&key=$apiKey';
      // final response = await http.get(Uri.parse(url));
    } on DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "ADD ADDRESS")
              .errorMessage());
      // isLoading(false);
    } catch (e) {
      // isLoading(false);
      if (kDebugMode) {
        print("selected lat long $e");
      }
    } finally {
      // isLoading(false);
    }
  }

  void selectLocationOnMap() async {
    var result = await Get.to(() => const SearchLocationOnMapScreen());
    if (result != null) {
      double latitude = double.parse(result[1].toString());
      double longitude = double.parse(result[2].toString());

      getAddressFromLatLong(
        latitude: latitude,
        longitude: longitude,
      );
      selectedLocation.value = result;
      debugPrint("Selected $result");
    }
  }

  Future<void> getAddressFromLatLong({
    required double latitude,
    required double longitude,
  }) async {
    print("latitude=============>:-$latitude");
    print("longitude==============>:-$longitude");
    latlng.value = LatLng(latitude, longitude);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    liveAddress.value =
        '${place.locality}, ${place.administrativeArea}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}, ${place.thoroughfare}, ${place.subThoroughfare}';
    print('liveAddress:- ${liveAddress.value}');
  }

  @override
  void onClose() {}

  increment() => count.value++;
}
