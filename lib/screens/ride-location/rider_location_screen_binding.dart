import 'package:get/get.dart';
import 'rider_location_screen_controller.dart';

class RiderLocationScreenBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<RiderLocationScreenController>(() => RiderLocationScreenController());
    }
}
