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

class SignInController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
CreateAccountModel model = CreateAccountModel();
TextEditingController emailCon = TextEditingController();
TextEditingController passCon = TextEditingController();

  @override
  void onInit() {
    // signIn(context: context);
    super.onInit();
  }

  @override
  void onReady() {}

  Future<dynamic> signIn() async {
    dio.FormData formData = dio.FormData.fromMap({
      'email':emailCon.text,
      'password':passCon.text,
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient.post(
        '${Config.baseUrl}login.php',
        data: formData,
      ).then((respo) async{
        var jsonResponse = jsonDecode(respo);
        var message = jsonResponse['message'];
        try {
          if (jsonResponse['status'] == false) {
            DioExceptions.showErrorMessage(Get.context!, message);
            print('Message: $message');
          } else {
            DioExceptions.showMessage(Get.context!, message);
            await SharedPref.saveString(Config.kAuth, jsonResponse['data']['api_token'].toString());
            // await SharedPref.saveString(Config.status, model.userType);
            getProfile();
          }
        } catch (e) {
          print('Error parsing JSON or accessing message: $e');
        }
      },);


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
        print("sign up $e");
      }
    } finally {
      isLoading(false);
    }
  }




  Future<dynamic> getProfile() async {
await getToken();

    isLoading(true);
    try {
      var response = await dioClient.post(
        '${Config.baseUrl}get_customer_profile.php',
        options: dio.Options( headers: {
          'Authorization': 'Bearer $token',
        },),

      ).then((respo) async{
        var jsonResponse = jsonDecode(respo);
         model = CreateAccountModel.fromJson(jsonResponse['data']);

        // model = jsonResponse['data'].map<CreateAccountModel>((json){
        //   return CreateAccountModel.fromJson(json);
        // }).toList();
        print('object=============${model.fullname}');
        var message = jsonResponse['message'];
        try {
          if (jsonResponse['status'] == false) {
            DioExceptions.showErrorMessage(Get.context!, message);
            print('Message: $message');
          } else {
            DioExceptions.showMessage(Get.context!, message);
            // await SharedPref.saveString(Config.status, model.userType);
            Get.toNamed(AppRoutes.HOMESCREEN);
          }
        } catch (e) {
          print('Error parsing JSON or accessing message: $e');
        }
      },);


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
        print("sign up $e");
      }
    } finally {
      isLoading(false);
    }
  }
  @override
  void onClose() {}
}
