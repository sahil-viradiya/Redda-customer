import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/model/create_account_model.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/services/firebase_services/auth_services.dart';

import '../../../main.dart';

class OtpController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController otpCon = TextEditingController();
  RxString mobileNo =
      ''.obs; // Assuming mobileNoController is your TextEditingController
  PostCreateModel? model;
  var verificationId = '';
  @override
  void onReady() {
    var data = Get.arguments;
    if (data != null) {
      verificationId = data;
    }
  }

  // Future<dynamic> verifyOtp({required String userId}) async {
  //   dio.FormData formData = dio.FormData.fromMap({
  //     'user_id': userId.toString(),
  //     'otp': otpCon.text.toString(),
  //   });
  //   log('============= Form DAta ${formData.fields}');
  //   isLoading(true);
  //   try {
  //     var response = await dioClient
  //         .post(
  //       '${Config.baseUrl}verify_register_otp.php',
  //       data: formData,
  //     )
  //         .then(
  //       (respo) {
  //         // var respo = jsonDecode(respo);
  //         var message = respo['message'];
  //         try {
  //           if (respo['status'] == false) {
  //             DioExceptions.showErrorMessage(Get.context!, message);
  //             print('Message: $message');
  //           } else {
  //             DioExceptions.showMessage(Get.context!, message);

  //             Get.toNamed(AppRoutes.LOGIN);
  //           }
  //         } catch (e) {
  //           print('Error parsing JSON or accessing message: $e');
  //         }
  //         Get.toNamed(AppRoutes.LOGIN);
  //       },
  //     );
  //   } on dio.DioException catch (e) {
  //     print("status Code ${e.response?.statusCode}");
  //     print('Error $e');
  //     DioExceptions.showErrorMessage(
  //         Get.context!,
  //         DioExceptions.fromDioError(dioError: e, errorFrom: "CREATE ACCOUNT")
  //             .errorMessage());
  //     isLoading(false);
  //   } catch (e) {
  //     isLoading(false);
  //     if (kDebugMode) {
  //       print("sign up $e");
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void verifyOtp() async {
    // This should come from the codeSent callback
    final otpCode = otpCon.text
        .trim(); // Assuming otpController is your TextEditingController for OTP input

    AuthService().verifyOtp(
      verificationId: verificationId,
      otpCode: otpCode,
      onVerificationSuccess: (UserCredential userCredential) {
        log("Navigate to the home screen or next step after successful OTP verification.");
        loadPostCreateModel();
        // Handle navigation or next steps after successful verification
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
        DioExceptions.showErrorMessage(Get.context!, errorMessage);

        // Show error message to the user or handle verification failure
      },
    );
  }
// resend otp
  void resendOtp() async {
    const phoneCode = '+91'; // Example country code

    await SharedPref.readObject('postCreateModel');

    log("resend ${model!.mobileNo}");
    AuthService().resendOtp(
      phoneCode: phoneCode,
      mobileNumber: model!.mobileNo,
      onCodeSent: (String verificationId, int? resendToken) {
        log("Navigate to OTP screen or update UI after OTP is resent.");
        verificationId=verificationId;
        // Handle navigation or UI update after OTP is resent
      },
      onVerificationCompleted: (PhoneAuthCredential credential) {
        log("Verification completed automatically with credential.");
        // Handle auto verification completion (if applicable)
      },
      onVerificationFailed: (String errorMessage) {
        log("Show error message to user: $errorMessage");
        DioExceptions.showErrorMessage(Get.context!, errorMessage);

        // Show error message to the user or handle resend failure
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {

        log("Auto-retrieval timed out. Prompt user to enter the OTP manually.");
        // Handle timeout scenario
      },
    );
  }

  Future<PostCreateModel?> loadPostCreateModel() async {
    Map<String, dynamic>? jsonMap =
        await SharedPref.readObject('postCreateModel');
    if (jsonMap != null) {
      model = PostCreateModel.fromJson(jsonMap);
      print("PostCreateModel loaded successfully: ${model?.fullName}");
      mobileNo.value = model!.mobileNo.toString();
      signUp(
          context: Get.context!,
          fullName: model?.fullName ?? "",
          email: model?.email ?? "",
          mobileNo: model?.mobileNo ?? "",
          password: model?.password ?? "",
          confirmPassword: model?.confirmPassword ?? "");
      return model;
    }
    print("No PostCreateModel found in SharedPreferences.");
    return null;
  }

  Future<dynamic> signUp(
      {required BuildContext context,
      required String fullName,
      required String email,
      required String mobileNo,
      required String password,
      required String confirmPassword}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'fullname': fullName.trim(),
      'email': email.trim(),
      'mobile_no': mobileNo.trim(),
      'password': password.trim(),
      'confirm_password': confirmPassword.trim(),
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
          Get.toNamed(AppRoutes.LOGIN);
          // log(" id   ${response['data']['user_id']}");
          // await SharedPref.saveString(
          //     Config.userId, response['data']['user_id'].toString());
          // Get.toNamed(AppRoutes.OTPSCREEN,
          //     arguments: {'userId': response['data']['user_id']});
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

  @override
  void onClose() {}

  increment() => count.value++;
}
