import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/ride-location/rider_location_screen.dart';
import 'package:redda_customer/screens/wallet/wallet_controller.dart';
import 'package:redda_customer/screens/wallet/wallet_screen.dart';

class CheckoutController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  final WalletController _controller = Get.put(WalletController());
  @override
  void onReady() {}
  Future<dynamic> creatRide({
    required String rideId,
  }) async {
    dio.FormData formData = dio.FormData.fromMap({
      'ride_id': rideId,
    });
    log('============= Form DAta $formData');

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
              //todo
              payNowDailog(context: Get.context!, controller: _controller);
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              // Get.offNamedUntil(
              //   AppRoutes.HOMESCREEN,
              //   (Route<dynamic> route) => route.isFirst,
              // );
              //  Get.toNamed(AppRoutes.CHECKOUT);
              Get.to(()=> const RiderLocationScreen());
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
