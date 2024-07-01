import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DropAddressDetailsController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = 'home'.obs;
final arguments = Get.arguments;


  TextEditingController dropAddCon = TextEditingController();
  TextEditingController dropLandCon = TextEditingController();
  TextEditingController dropSenderCon = TextEditingController();
  TextEditingController dropMobileCon = TextEditingController();
  RxDouble dropLat = 0.0.obs;
  RxDouble dropLng = 0.0.obs;

  @override
  void onInit() {
    dropLat.value = double.parse( arguments?[0]);
    dropLng.value = double.parse( arguments?[1]);
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
