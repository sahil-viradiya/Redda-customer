import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/model/fetch_address_model.dart';

class AddressDetailsController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  var latCon = ''.obs;
  var longCon = ''.obs;

  TextEditingController sendersName = TextEditingController();
  TextEditingController sendersMobileNo = TextEditingController();
  TextEditingController landCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  final TextEditingController myController = TextEditingController();

  @override
  void onReady() {
    fetchAddress();
  }

  var searchQuery = ''.obs;
  RxList<FetchAddressModel> filteredAddresses = <FetchAddressModel>[]
      .obs; // Ensure this is of type RxList<FetchAddressModel>
  var isListVisible = true.obs;

  List<FetchAddressModel> addresses = []; // List of all addresses

  void filterAddresses(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      filteredAddresses.value = addresses
          .where((FetchAddressModel address) =>
              address.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isListVisible.value = true; // Show the list when filtering
    } else {
      filteredAddresses.value = addresses;
      isListVisible.value = false; // Hide the list when input is empty
    }
  }

  void selectAddress(FetchAddressModel address) {
    searchQuery.value = address.address;
    sendersMobileNo.text = address.senderMobile;
    log("selected address ${address.senderMobile}");
    isListVisible.value = false; // Hide the list when an address is selected
  }

  Future<dynamic> fetchAddress() async {
    try {
      var response =
          await dioClient.get('${Config.baseUrl}get_customer_address.php');

      var responseData = response;

      if (responseData != null && responseData['data'] != null) {
        var message = responseData['message'];
        if (responseData['status'] == false) {
          DioExceptions.showErrorMessage(Get.context!, message);
          return []; // Return an empty list if the status is false
        } else {
          DioExceptions.showMessage(Get.context!, message);
          // Return a list of maps instead of a list of model objects
          List<FetchAddressModel> model =
              responseData['data'].map<FetchAddressModel>((json) {
            return FetchAddressModel.fromJson(json);
          }).toList();

          addresses = model;
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print("Status Code: ${e.response?.statusCode}");
      print('Error: $e');
      DioExceptions.showErrorMessage(
        Get.context!,
        DioExceptions.fromDioError(dioError: e, errorFrom: "FETCH ADDRESS")
            .errorMessage(),
      );
      return []; // Return an empty list if an exception occurs
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return []; // Return an empty list for any other exception
    }

    @override
    void onClose() {}
  }
}

class TestItem {
  String label;
  dynamic value;
  TestItem({required this.label, this.value});

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(label: json['label'], value: json['value']);
  }
}
