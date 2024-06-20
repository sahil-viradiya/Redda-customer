import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DropAddressDetailsController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = ''.obs;

  TextEditingController dropAddCon = TextEditingController();
  TextEditingController dropLandCon = TextEditingController();
  TextEditingController dropSenderCon = TextEditingController();
  TextEditingController dropMobileCon = TextEditingController();
  var dropLat = '0'.obs;
  var dropLng = '0'.obs;

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
