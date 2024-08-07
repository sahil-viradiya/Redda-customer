import 'package:get/get.dart';
import 'package:redda_customer/services/internate_services/network_controller.dart';

class DependencyInjection {
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}