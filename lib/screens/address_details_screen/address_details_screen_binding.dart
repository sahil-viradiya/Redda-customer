import 'package:get/get.dart';
import 'address_details_screen_controller.dart';

class AddressBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
    }
}
