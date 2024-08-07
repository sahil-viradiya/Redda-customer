import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isOnline = false.obs;
  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (result[0] == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          "PLEASE CHECK YOUR INTERNET CONNECTION",
          style: TextStyle(color: white, fontSize: 14),
        ),
        isDismissible: false,
        backgroundColor: Colors.red[400]!,
        icon: const Icon(
          Icons.wifi_off,
          color: white,
          size: 35,
        ),
        margin: const EdgeInsets.all(0),                                                                                                                                                                                            
        snackStyle: SnackStyle.GROUNDED,
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.closeCurrentSnackbar();
    }
  }
} 
