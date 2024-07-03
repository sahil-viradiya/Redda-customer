import 'package:get/get.dart';

class LinkAccountController extends GetxController {
    final count = 0.obs;


    @override
    void onReady() {}

    @override
    void onClose() {}

    increment() => count.value++;
}
