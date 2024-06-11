import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/Utils/pref.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/model/create_account_model.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';

import '../../../main.dart';
import '../../widget/search_location_on_map_screen.dart';
class AddressController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final SignInController _signInController = Get.put(SignInController());
  Rx<String> liveAddress = ''.obs;
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  var selectedLocation = ''.obs;
  TextEditingController houseCon = TextEditingController();
  TextEditingController areaCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  @override
  void onInit() {
    nameCon.text = _signInController.model.fullname ?? "";
    mobileNo.text = _signInController.model.mobileNo ?? "";
    emailCon.text = _signInController.model.email ?? "";
    super.onInit();
  }

  @override
  void onReady() {}


  void selectLocationOnMap() async {
    var result = await Get.to(() => const SearchLocationOnMapScreen());
    if (result != null) {
      double latitude = double.parse(result[1].toString());
      double longitude = double.parse(result[2].toString());

      getAddressFromLatLong(
        latitude: latitude,
        longitude: longitude,
      );
      selectedLocation.value = result;
      debugPrint("Selected $result");
    }
  }

  Future<void> getAddressFromLatLong({
    required double latitude,
    required double longitude,
  }) async {
    print("latitude=============>:-$latitude");
    print("longitude==============>:-$longitude");
    latlng.value = LatLng(latitude, longitude);

    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    liveAddress.value =
    '${place.locality}, ${place.administrativeArea}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}, ${place.thoroughfare}, ${place.subThoroughfare}';
    print('liveAddress:- ${liveAddress.value}');
  }




  Future<dynamic> addAddress() async {
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


  @override
  void onClose() {}

  increment() => count.value++;
}
