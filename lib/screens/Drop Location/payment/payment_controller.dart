import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dio/dio.dart' as dio;
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/screens/wallet/wallet_controller.dart';

class PaymentController extends GetxController {
  final count = 0.obs;
  var selectedRadio = 0.obs;
  late Razorpay _razorpay;
  RxBool isLoading = false.obs;

  final _amountController = TextEditingController(text: '125');
  final WalletController walletController = Get.find();

  // Method to change the selected radio value
  void changeRadio(int value) {
    selectedRadio.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({required String rs}) async {
    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': (double.parse(rs) * 100).toInt(), // Razorpay uses paise
      'name': 'Redda',

      'description': 'Add Money to Wallet',
      'prefill': {
        'contact': '9725558828',
        'email': 'sahuilviradiya7190@gmail.com',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}-----${response.data}");
    if (response.paymentId != null) {
walletController.addWalletBalance(transactionId: response.paymentId.toString());
      // tempRide(rideId: dropAddScreenCon.tempRideMdel.value.rideId.toString());
    }
    // updateWallte(paymentId: response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        "Payment Error: ${response.code} - ${response.message}"); // 2 // undefined
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  Future<dynamic> updateWallte({required String paymentId}) async {
    dio.FormData formData = dio.FormData.fromMap({
      // 'name':_signInController.model?.fullname,
      // 'house':house.text,
      // 'area':area.text,
      // 'direction':direction.text,
      // 'mobile_no': _signInController.model?.mobileNo,
      // 'address_type': addressType,
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}add_user_address.php',
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "ADD ADDRESS")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("sign IN $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onReady() {}
   @override
  void onClose() {}

  increment() => count.value++;
}
