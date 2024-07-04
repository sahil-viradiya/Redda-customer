import 'package:get/get.dart';
import 'set_drop_location_controller.dart';

class SetDropLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetDropLocationController>(() => SetDropLocationController());
  }
}
