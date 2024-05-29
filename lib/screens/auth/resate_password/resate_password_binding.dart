import 'package:get/get.dart';
import 'package:redda_customer/screens/auth/resate_password/resate_password_controller.dart';


class ResatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResatePasswordController>(() => ResatePasswordController());
  }
}
