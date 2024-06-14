import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redda_customer/screens/Pick%20Up%20Location/location_sugetion.dart';
import 'package:redda_customer/widget/search_location_on_map_screen.dart';

class SetPickUpLocationController extends GetxController {
  final count = 0.obs;
  Rx<String> liveAddress = ''.obs;
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  var selectedLocation = ''.obs;

  final TextEditingController controller = TextEditingController();
  final PlacesService placesService = PlacesService();
  RxList<dynamic> suggestions = <dynamic>[].obs;

  void onSearchChanged() async {
    if (controller.text.isEmpty) {
      suggestions.clear();
      update();
      return;
    }

    final fetchedSuggestions = await placesService.getPlaceSuggestions(controller.text);
    suggestions.assignAll(fetchedSuggestions);
    update();
  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

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
