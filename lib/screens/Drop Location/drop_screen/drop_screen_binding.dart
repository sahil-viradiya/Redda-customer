import 'package:get/get.dart';
import 'drop_screen_controller.dart';

class DropScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropScreenController>(() => DropScreenController());
  }
}
