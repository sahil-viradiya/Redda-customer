import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';

import '../../../Utils/constant.dart';
import '../../../Utils/network_client.dart';
import '../../../constant/api_key.dart';
import '../../../main.dart';
import '../../../route/app_route.dart';
import '../drop_screen/drop_screen_controller.dart';
List list = [];
class PickOrSendAnyController extends GetxController {
  final count = 0.obs;
  var dropAdd = ''.obs;
  var dropLand = ''.obs;
  var dropReviver = ''.obs;
  var dropMobile = ''.obs;
  var dropLat = 0.0.obs;
  RxDouble distance = 0.0.obs;
  var estimatedTime = ''.obs;
  var dropLng = 0.0.obs;
  var addressStatus = ''.obs;
  RxBool isLoading = false.obs;
  final dropScreenCon = Get.put(DropScreenController());

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    dropAdd.value = arguments['dropAdd'] ?? '';
    dropLand.value = arguments['dropLand'] ?? '';
    dropReviver.value = arguments['dropSend'] ?? '';
    dropMobile.value = arguments['dropMobile'] ?? '';
    dropLat.value =double.parse(  arguments['dropLat'] ?? 0.0);
    dropLng.value =double.parse( arguments['dropLng'] ?? 0.0);
    addressStatus.value = arguments['addresStatus'] ?? '';
  }

  @override
  void onReady() {}

  Future<dynamic> ride() async {
    dio.FormData formData = dio.FormData.fromMap({
      'pickUpLatitude': dropScreenCon.pickLat.value,
      'pickUpLongitude': dropScreenCon.pickLng.value,
      'pickup_address': dropScreenCon.pickLoc.value,
      'sender_landmark': dropScreenCon.pickLand.value,
      'sender_name': dropScreenCon.pickName.value,
      'sender_mobile_no': dropScreenCon.pickNumber.value,
      'dropOffLatitude': dropLat.value,
      'dropOffLongitude': dropLng.value,
      'drop_address': dropAdd.value.toString(),
      'receiver_landmark': dropLand.value,
      'receiver_name': dropReviver.value,
      'receiver_mobile_no': dropMobile.value,
      'address_type': addressStatus.value,
      'item_details':"table"
    });
    log('============= Form DAta ${list}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}ride.php',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: formData,
      )
          .then(
        (respo) async {
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
               Get.toNamed(AppRoutes.CHECKOUT);
            }
          } catch (e) {
            print('Error parsing JSON or accessing message: $e');
          }
        },
      );
    } on dio.DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(dioError: e, errorFrom: "ADD RIDE")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("RIDE ERROR $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {}

  increment() => count.value++;
}
