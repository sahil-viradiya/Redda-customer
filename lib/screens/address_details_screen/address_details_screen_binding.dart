import 'package:get/get.dart';
import 'address_details_screen_controller.dart';

class AddAddressBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
    }
}
