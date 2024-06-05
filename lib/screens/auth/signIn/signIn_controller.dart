import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/api_client.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';

class SignInController extends GetxController {
  final count = 0.obs;
  late BuildContext context;

  SignInController(this.context);

  @override
  void onInit() {
    signIn(context: context);
    super.onInit();
  }

  @override
  void onReady() {}

  signIn({required BuildContext context}) async {
    final dio = Dio();

    try {
      var response = await DioClient('${Common.baseUrl}register.php', dio);
      log('${response}');
    } on DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print('Error $e');
      DioExceptions.showErrorMessage(
          context,
          DioExceptions.fromDioError(dioError: e, errorFrom: "getProfileData")
              .errorMessage());
    } catch (e) {
      if (kDebugMode) {
        print("sign up $e");
      }
    }
  }

  @override
  void onClose() {}
}
