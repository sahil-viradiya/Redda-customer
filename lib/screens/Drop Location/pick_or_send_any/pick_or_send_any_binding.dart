import 'package:get/get.dart';
import 'pick_or_send_any_controller.dart';

class PickOrSendAnyBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PickOrSendAnyController>(() => PickOrSendAnyController());
    }
}
