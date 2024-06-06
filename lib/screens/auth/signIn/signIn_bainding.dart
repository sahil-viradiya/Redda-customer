import 'package:get/get.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    // Since context is not available at this point,
    // we initialize the controller later in the view
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
