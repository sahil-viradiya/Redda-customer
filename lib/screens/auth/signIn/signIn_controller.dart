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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class SignInController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  CreateAccountModel model = CreateAccountModel();

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  @override
  void onReady() {}

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    if (userData != null) {
      model = CreateAccountModel.fromJson(jsonDecode(userData));
      // Update your UI if needed
    }
  }

  Future<void> _saveUserData(CreateAccountModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(model.toJson()));
  }

  Future<dynamic> signIn() async {
    dio.FormData formData = dio.FormData.fromMap({
      'email': emailCon.text,
      'password': passCon.text,
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}login.php',
        data: formData,
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
              await SharedPref.saveString(
                  Config.kAuth, respo['data']['api_token'].toString());
              // await SharedPref.saveString(Config.status, model.userType);
              getProfile();
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

  Future<dynamic> getProfile() async {
    await getToken();

    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}get_customer_profile.php',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      )
          .then(
        (respo) async {
          // var respo = jsonDecode(respo);
          model = CreateAccountModel.fromJson(respo['data']);
          _saveUserData(model);

          // model = respo['data'].map<CreateAccountModel>((json){
          //   return CreateAccountModel.fromJson(json);
          // }).toList();
          print('object=============${model.fullname}');
          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              log(" id   ${respo['data']['user_id']}");
              await SharedPref.saveString(
                  Config.userId, respo['data']['user_id'].toString());

              // await SharedPref.saveString(Config.status, model.userType);
              Get.toNamed(AppRoutes.HOMESCREEN);
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "GET PROFILE")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("PROFILE IN $e");
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {}
}
