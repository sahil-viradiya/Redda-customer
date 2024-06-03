import 'package:get/get.dart';
import 'add_new_card_controller.dart';

class AddNewCardBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<AddNewCardController>(() => AddNewCardController());
    }
}
