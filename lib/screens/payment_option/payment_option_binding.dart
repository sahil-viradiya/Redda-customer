import 'package:get/get.dart';
import 'payment_option_controller.dart';

class PaymentOptionBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PaymentOptionController>(() => PaymentOptionController());
    }
}
