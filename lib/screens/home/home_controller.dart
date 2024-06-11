import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_image.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final currentIndex = 0.obs;
  final List? items = [AppImage.SLIDE, AppImage.SLIDE, AppImage.SLIDE];
  var status = ''.obs;
  RxString currentLocation = ''.obs;
  final CarouselController slideController = CarouselController();
  Rx<Key> locationWidgetKey = UniqueKey().obs; // Key to rebuild the widget

  void rebuildLocationWidget() {
    locationWidgetKey.value = UniqueKey(); // Assign a new key to force rebuild
  }

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
