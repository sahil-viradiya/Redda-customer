import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DropAddressDetailsController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = 'home'.obs;

  TextEditingController dropAddCon = TextEditingController();
  TextEditingController dropLandCon = TextEditingController();
  TextEditingController dropSenderCon = TextEditingController();
  TextEditingController dropMobileCon = TextEditingController();
  RxDouble dropLat = 0.0.obs;
  RxDouble dropLng = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
