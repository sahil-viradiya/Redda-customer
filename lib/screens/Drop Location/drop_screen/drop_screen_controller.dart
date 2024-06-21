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
    final arguments = Get.arguments;
    if (arguments != null) {
      pickLoc.value = arguments['address'] ?? "";
      pickLand.value = arguments['landmark'] ?? "";
      pickName.value = arguments['senderName'] ?? "";
      pickNumber.value = arguments['senderMo'] ?? "";
      pickLat.value = double.parse(arguments['lat']?.toString() ?? '0.0');
      pickLng.value = double.parse(arguments['lng']?.toString() ?? '0.0');
      // log("all pick value =====***==== ${controller.pickUpLocationList}");
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
