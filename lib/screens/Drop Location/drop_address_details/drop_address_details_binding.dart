import 'package:get/get.dart';
import 'drop_address_details_controller.dart';

class DropAddressDetailsBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<DropAddressDetailsController>(() => DropAddressDetailsController());
    }
}
