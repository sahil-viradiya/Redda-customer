import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/location_sugetion.dart';

import '../../../Utils/network_client.dart';
import '../../../main.dart';

class SetDropLocationController extends GetxController {
  final count = 0.obs;
  final TextEditingController locationController = TextEditingController();
  final PlacesService placesService = PlacesService();
  var selectedDropLat = '0'.obs;
  var selectedDropLng = '0'.obs;
  RxList<dynamic> suggestions = <dynamic>[].obs;


  @override
  void onReady() {}

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

  Future<dynamic> getLatLong(String placeId) async {
    try {
      var response = await dioClient.get(
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${placesService.apiKey}");
      selectedDropLat .value =
          response['result']['geometry']['location']['lat'].toString();
      selectedDropLng.value =
          response['result']['geometry']['location']['lng'].toString();
      log("lat long=====>   ${response['result']['geometry']['location']['lat']}");
      // final String url =
      //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?place_id=$placeId&key=$apiKey';
      // final response = await http.get(Uri.parse(url));
    } on DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "ADD DROP ADDRESS")
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

}
