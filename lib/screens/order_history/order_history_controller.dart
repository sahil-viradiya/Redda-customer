
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/screens/order_history/order_history_model.dart';

class OrderHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt totalOrder = 0.obs;
  RxList<OrderHistoryModel> model = RxList<OrderHistoryModel>();


  @override
  void onReady() {
    orderHistory();
  }

 Future<void> orderHistory() async {
getToken();
  if (token == null) {
    if (kDebugMode) {
      print("Token is null");
    }
    return;
  }
  
  isLoading(true);
  try {
    final response = await dioClient.post(
      '${Config.baseUrl}get_order.php',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response == null) {
      throw Exception("Null response received");
    }

    final message = response['message'] as String? ?? "No message available";
    final status = response['status'] as bool? ?? false;
    final data = response['data'] as List<dynamic>?;

    if (!status) {
      DioExceptions.showErrorMessage(Get.context!, message);
      if (kDebugMode) {
        print('Message: $message');
      }
    } else if (data != null) {
      model.value = data.map((json) =>
              OrderHistoryModel.fromJson(json as Map<String, dynamic>))
          .toList();

      if (model.isNotEmpty) {
        totalOrder.value = model.length;
      }
      DioExceptions.showMessage(Get.context!, message);
    } else {
      DioExceptions.showErrorMessage(Get.context!, "No data available");
    }
  } on dio.DioException catch (e) {
    if (kDebugMode) {
      print("Status Code: ${e.response?.statusCode}");
      print('Error: $e');
    }
    DioExceptions.showErrorMessage(
      Get.context!,
      DioExceptions.fromDioError(dioError: e, errorFrom: "order history")
          .errorMessage(),
    );
  } catch (e) {
    if (kDebugMode) {
      print("Order history error: $e");
    }
  } finally {
    isLoading(false);
  }
}
}
