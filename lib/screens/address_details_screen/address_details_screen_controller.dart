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
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/screens/address_details_screen/address_details_screen_model.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';

import '../../../main.dart';
import '../../widget/search_location_on_map_screen.dart';
class AddressController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = ''.obs;
  RxBool isLoading = false.obs;
  final SignInController _signInController = Get.put(SignInController());
  Rx<String> liveAddress = ''.obs;
  Rx<LatLng> latlng = const LatLng(0, 0).obs;
  var selectedLocation = ''.obs;
  TextEditingController houseCon = TextEditingController();
  TextEditingController areaCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();


  TextEditingController house = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController direction = TextEditingController();

  @override
  void onInit() {
    getAddress();
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
      'name':_signInController.model.fullname,
      'address':  house.text+area.text+direction.text,
      'mobile_no': _signInController.model.mobileNo,
      'address_type': addressType,
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
      ).then((respo) async {
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

  GetAddressModel? getAddressModel;
  Future<GetAddressModel?> getAddress() async {
    dio.FormData formData = dio.FormData.fromMap({
      'user_id':_signInController.model.userId,
    });
    log('============= Form DAta ${formData.fields}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}get_user_address.php',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: formData,
      ).then((respo) async {
          log("================================${respo['data']}===============");

          var message = respo['message'];
          try {
            if (respo['status'] == false) {
              DioExceptions.showErrorMessage(Get.context!, message);
              print('Message: $message');
            } else {
              DioExceptions.showMessage(Get.context!, message);
              getAddressModel = GetAddressModel.fromMap(respo);
              print("=======GET ADDRESS===> ${getAddressModel?.data![0].addressType}");
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "GET ADDRESS")
              .errorMessage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print("GET ADDRESS $e");
      }
    } finally {
      isLoading(false);
    }
    return getAddressModel;
  }



  @override
  void onClose() {}
  increment() => count.value++;
}
