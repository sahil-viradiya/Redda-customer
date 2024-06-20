import 'package:get/get.dart';

class DropScreenController extends GetxController {
    final count = 0.obs;
    final RxString pickLoc = ''.obs;
    final RxString pickLand = ''.obs;
    final RxString pickName = ''.obs;
    final RxString pickNumber = ''.obs;
    final RxDouble pickLat = 0.0.obs;
    final RxDouble pickLng = 0.0.obs;


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
