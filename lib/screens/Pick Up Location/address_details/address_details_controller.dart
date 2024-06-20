import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_rx/get_rx.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/model/create_account_model.dart';
import 'package:redda_customer/route/app_route.dart';

import '../../../main.dart';
import '../../auth/signIn/signIn_controller.dart';
class AddressDetailsController extends GetxController {
    final count = 0.obs;
    RxBool isLoading = false.obs;
    var latCon = ''.obs;
    var longCon = ''.obs;

    TextEditingController sendersName = TextEditingController();
    TextEditingController sendersMobileNo = TextEditingController();
    TextEditingController landCon = TextEditingController();
    TextEditingController addressCon = TextEditingController();

    @override
    void onInit() {

    super.onInit();
    }

    @override
    void onReady() {}


    // Future<dynamic> addAddress() async {
    //     dio.FormData formData = dio.FormData.fromMap({
    //         'name': emailCon.text,
    //         'address': addressCon.text,
    //         'mobile_no':mobileNo.text,
    //         'email':emailCon.text,
    //
    //         // 'address_type':
    //     });
    //     log('============= Form DAta ${formData.fields}');
    //     isLoading(true);
    //     try {
    //         var response = await dioClient
    //             .post(
    //             '${Config.baseUrl}login.php',
    //             data: formData,
    //         )
    //             .then(
    //                 (respo) async {
    //                 // var respo = jsonDecode(respo);
    //                 log("================================${respo['data']}===============");
    //
    //                 var message = respo['message'];
    //                 try {
    //                     if (respo['status'] == false) {
    //                         DioExceptions.showErrorMessage(Get.context!, message);
    //                         print('Message: $message');
    //                     } else {
    //                         DioExceptions.showMessage(Get.context!, message);
    //                         // log("================================${ respo['data']['api_token']}===============");
    //                         await SharedPref.saveString(
    //                             Config.kAuth, respo['data']['api_token'].toString());
    //                         // await SharedPref.saveString(Config.status, model.userType);
    //
    //                     }
    //                 } catch (e) {
    //                     print('Error parsing JSON or accessing message: $e');
    //                 }
    //             },
    //         );
    //     } on dio.DioException catch (e) {
    //         print("status Code ${e.response?.statusCode}");
    //         print('Error $e');
    //         DioExceptions.showErrorMessage(
    //             Get.context!,
    //             DioExceptions.fromDioError(dioError: e, errorFrom: "CREATE ACCOUNT")
    //                 .errorMessage());
    //         isLoading(false);
    //     } catch (e) {
    //         isLoading(false);
    //         if (kDebugMode) {
    //             print("sign IN $e");
    //         }
    //     } finally {
    //         isLoading(false);
    //     }
    // }



    @override
    void onClose() {}

    increment() => count.value++;
}
