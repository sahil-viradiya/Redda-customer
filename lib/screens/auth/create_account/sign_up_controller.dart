import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/model/create_account_model.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/services/firebase_services/auth_services.dart';

import '../../../main.dart';

class SignUpController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool checkTC = false.obs;
  BuildContext? context;
  CreateAccountModel model = CreateAccountModel();
  PostCreateModel? createAccountModel;
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword = TextEditingController();

  // SignUpController(this.context);

  @override
  void onInit() {
    createAccountModel = PostCreateModel(
        fullName: '',
        email: '',
        mobileNo: '',
        password: '',
        confirmPassword: '');
    super.onInit();
  }

  @override
  void onReady() {}

  Future<dynamic> signUp({required BuildContext context}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'fullname': createAccountModel?.fullName.trim(),
      'email': createAccountModel?.email.trim(),
      'mobile_no': createAccountModel?.mobileNo.trim(),
      'password': createAccountModel?.password.trim(),
      'confirm_password': createAccountModel?.confirmPassword.trim(),
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient.post(
        '${Config.baseUrl}register.php',
        data: formData,
      );
      print('Response type: ${response.runtimeType}');

      // var response = jsonDecode(response);
      var message = response['message'];
      try {
        if (response['status'] == false) {
          DioExceptions.showErrorMessage(context, message);
          print('Message: $message');
        } else {
          DioExceptions.showMessage(context, message);
          log(" id   ${response['data']['user_id']}");
          await SharedPref.saveString(
              Config.userId, response['data']['user_id'].toString());
          Get.toNamed(AppRoutes.OTPSCREEN,
              arguments: {'userId': response['data']['user_id']});
        }
      } catch (e) {
        print('Error parsing JSON or accessing message: $e');
      }
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
        print("sign up-- $e");
      }
    } finally {
      isLoading(false);
    }
  }

  void verifyNumber() async {
    isLoading.value = true;

    const phoneCode = '+91'; // Example country code
    final mobileNo = createAccountModel!
        .mobileNo; // Assuming mobileNoController is your TextEditingController
void savePostCreateModel(PostCreateModel model) async {
  await SharedPref.saveObject('postCreateModel', model.toJson());
  print("PostCreateModel saved successfully.");
}
    AuthService().verifyPhoneNumber(
      phoneCode: phoneCode,
      mobileNumber: mobileNo,
      codeSent: (String verificationId, int? resendToken) {
        log("Navigate to OTP screen after code sent.");
       savePostCreateModel(createAccountModel!);
          Get.toNamed(AppRoutes.OTPSCREEN, arguments: verificationId);
        isLoading.value = false;

        // Handle navigation or UI update after code is sent
      },
      onVerificationCompleted: (PhoneAuthCredential credential) {
        log("Auto verification completed.");
      

        // Handle what happens when verification is completed automatically
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
        isLoading.value = false;

        // Show error message to the user or handle failure
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {
        log("Auto retrieval timeout. Please enter the code manually.");
        isLoading.value = false;

        // Handle auto-retrieval timeout
      },
    );
  }

  @override
  void onClose() {}

  increment() => count.value++;
}
