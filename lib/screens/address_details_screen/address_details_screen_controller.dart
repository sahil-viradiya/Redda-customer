import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../auth/signIn/signIn_controller.dart';

class AddressController extends GetxController {
  final count = 0.obs;
  final SignInController _signInController = Get.put(SignInController());

  TextEditingController nameCon = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  @override
  void onInit() {
    nameCon.text = _signInController.model.fullname ?? "";
    mobileNo.text = _signInController.model.mobileNo ?? "";
    emailCon.text = _signInController.model.email ?? "";
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  increment() => count.value++;
}
