import 'package:get/get.dart';
import 'package:redda_customer/screens/auth/create_account/sign_up_controller.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
