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
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/address_details_screen/add-new_address.dart';
import 'package:redda_customer/screens/address_details_screen/address_details_screen_model.dart';
import 'package:redda_customer/screens/auth/signIn/signIn_controller.dart';

import '../../../main.dart';
import '../../widget/search_location_on_map_screen.dart';

class AddressController extends GetxController {

  final count = 0.obs;
  final selectedIndex = 0.obs;
  final addressType = 'home'.obs;
  final SignInController _signInController = Get.put(SignInController());

  var selectedLocation = ''.obs;

  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxBool addToSave = false.obs;
  Rx<String> liveAddress = ''.obs;
  Rx<LatLng> latlng = const LatLng(0, 0).obs;

  GetAddressModel? getAddressModel;

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
      'name':_signInController.model?.fullname,
      'house':house.text,
      'area':area.text,
      'direction':direction.text,
      'mobile_no': _signInController.model?.mobileNo,
      'address_type': addressType,
    });
    log('============= Form DAta ${formData.fields}');
    log('============= FULL NAME===> ${_signInController.model?.fullname}');
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
              Get.delete<AddressController>();
              Get.back();

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

  Future<GetAddressModel?> getAddress() async {
    await getToken();
    isLoading(true);

log("get address===================$token");
    dio.FormData formData = dio.FormData.fromMap({
      'user_id':_signInController.model?.userId,
    });
    log('============= Form DAta ${formData.fields}');
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
              isLoading(false);
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

  Future<dynamic> deleteAddress(var addressId) async {
    print("--------------->>>>${addressId}");
    dio.FormData formData = dio.FormData.fromMap({
      'address_id':addressId,
    });
    log('============= Form DAta ${formData.fields}');
    //isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}delete_user_address.php',
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
          DioExceptions.fromDioError(dioError: e, errorFrom: "DELETE ADDRESS")
              .errorMessage());
      //isLoading(false);
    } catch (e) {
      //isLoading(false);
      if (kDebugMode) {
        print("DELETE ADDRESS $e");
      }
    } finally {
      //isLoading(false);
    }
    return getAddressModel;
  }

  Future<dynamic> updateAddress({required String id}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'name':_signInController.model?.fullname,
      'house':house.text,
      'area':area.text,
      "address_id": id.toString(),
      'direction':direction.text,
      'mobile_no': _signInController.model?.mobileNo,
      'address_type': addressType,
    });
    log('============= Form DAta ${formData.fields}');
    log('============= FULL NAME===> ${_signInController.model?.fullname}');
    isLoading(true);
    try {
      var response = await dioClient
          .post(
        '${Config.baseUrl}update_user_address.php',
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
            Get.back();
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
  void onClose() {}
  increment() => count.value++;
}
