import 'package:get/get.dart';
import 'set_pick_up_location_controller.dart';

class SetPickUpLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPickUpLocationController>(
        () => SetPickUpLocationController());
  }
}
