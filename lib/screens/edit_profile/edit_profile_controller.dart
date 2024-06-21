import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/model/create_account_model.dart';
import 'package:redda_customer/route/app_route.dart';

import '../../../main.dart';
import '../auth/signIn/signIn_controller.dart';


class EditProfileController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;

  final SignInController _signInController = Get.put(SignInController());

  TextEditingController nameCon = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  @override
  void onInit() {
    nameCon.text = _signInController.model?.fullname ?? "";
    mobileNo.text = _signInController.model?.mobileNo ?? "";
    emailCon.text = _signInController.model?.email ?? "";
    super.onInit();
  }

  @override
  void onReady() {}



  Future<dynamic> updateProfile() async {
    getToken();
    dio.FormData formData = dio.FormData.fromMap({
      'fullname': nameCon.text,
      'email': emailCon.text,
      'mobile_no':mobileNo.text
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}update_customer_profile.php',
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      )
          .then(
            (respo) async {
          // var respo = jsonDecode(respo);
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              // log("================================${ respo['data']['api_token']}===============");
            await _signInController.getProfile();
              Get.toNamed(AppRoutes.HOMESCREEN);

              // await SharedPref.saveString(Config.status, model.userType);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "CREATE ACCOUNT")
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
  void onClose() {}

  increment() => count.value++;
}
