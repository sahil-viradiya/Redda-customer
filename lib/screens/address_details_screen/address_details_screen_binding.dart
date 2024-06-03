import 'package:get/get.dart';
import 'address_details_screen_controller.dart';

class PAddressDetailsScreenBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PAddressDetailsScreenController>(() => PAddressDetailsScreenController());
    }
}
