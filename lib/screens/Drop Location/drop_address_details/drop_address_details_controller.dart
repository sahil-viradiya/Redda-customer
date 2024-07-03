import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/model/ride_details_model.dart';
import 'package:redda_customer/model/temp_ride_model.dart';

class DropAddressDetailsController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = 'home'.obs;
  final arguments = Get.arguments;

  TextEditingController dropAddCon = TextEditingController();
  TextEditingController dropLandCon = TextEditingController();
  TextEditingController dropSenderCon = TextEditingController();
  TextEditingController dropMobileCon = TextEditingController();
  RxDouble dropLat = 0.0.obs;
  RxDouble dropLng = 0.0.obs;
  RxBool isLoading = false.obs;
  Rx<TempRideMdel> tempRideMdel = TempRideMdel().obs;
  Rx<RideDetailsModel > rideDetailsModel = RideDetailsModel().obs;
  @override
  void onInit() {
    dropLat.value = double.parse(arguments?[0]);
    dropLng.value = double.parse(arguments?[1]);
    super.onInit();
  }

  @override
  void onReady() {}

  Future<dynamic> tempRide({
    required double pickLat,
    required double pickLng,
    required String pickUpAddress,
    required String senderLandMark,
    required String senderName,
    required String senderMobileNo,
    required double dropLat,
    required double dropLng,
    required String reciverAddress,
    required String reciverLandmark,
    required String reciverName,
    required String reciverMobileNo,
    required String addressType,
    String itemDetais = "Table",
  }) async {
    dio.FormData formData = dio.FormData.fromMap({
      'pickUpLatitude': pickLat,
      'pickUpLongitude': pickLng,
      'pickup_address': pickUpAddress,
      'sender_landmark': senderLandMark,
      'sender_name': senderName,
      'sender_mobile_no': senderMobileNo,
      'dropOffLatitude': dropLat,
      'dropOffLongitude': dropLng,
      'drop_address': reciverAddress,
      'receiver_landmark': reciverLandmark,
      'receiver_name': reciverName,
      'receiver_mobile_no': reciverMobileNo,
      'address_type': addressType,
      'item_details': itemDetais,
    });
    log('============= Form DAta $formData');
 rideDetailsModel.value = RideDetailsModel(
  pickLat: pickLat,
  pickLng: pickLng,
  pickUpAddress: pickUpAddress,
  senderLandMark: senderLandMark,
  senderName: senderName,
  senderMobileNo:senderMobileNo,
  dropLat:dropLat,
  dropLng: dropLng,
  reciverAddress: reciverAddress,
  reciverLandmark:  reciverLandmark,
  reciverName: reciverName,
  reciverMobileNo: reciverMobileNo,
  addressType: addressType,
);
 log('============= Form DAta ${rideDetailsModel.value.addressType}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}temp_ride.php',
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
              tempRideMdel.value = TempRideMdel.fromJson(respo['data']);
          log("================================${tempRideMdel.value.totalCharges}===============");

              //  Get.toNamed(AppRoutes.CHECKOUT);
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
