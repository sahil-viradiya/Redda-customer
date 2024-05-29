import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../constant/app_image.dart';

class HomeController extends GetxController {
    final count = 0.obs;
    final currentIndex = 0.obs;
    final List? items=[AppImage.SLIDE,AppImage.SLIDE,AppImage.SLIDE];


    final CarouselController slideController = CarouselController();
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
