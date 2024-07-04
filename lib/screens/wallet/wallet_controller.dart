
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:redda_customer/Utils/constant.dart';
import 'package:redda_customer/Utils/network_client.dart';
import 'package:redda_customer/constant/api_key.dart';
import 'package:redda_customer/main.dart';
import 'package:redda_customer/model/transcation_history_model.dart';
import 'package:redda_customer/model/wallet_balance_model.dart';

class WalletController extends GetxController {
  final count = 0.obs;
  RxBool isLoading = false.obs;
  Rx<WalletBalanceModel> walletBalanceModel = WalletBalanceModel().obs;
  RxList<TranscationHistoryModel> transcationHistoryModel =
      <TranscationHistoryModel>[].obs;
  final TextEditingController amountController = TextEditingController();
  Future<void> fetchWalletBalance() async {
    isLoading(true);
    try {
      final response = await dioClient.post(
        '${Config.baseUrl}get_customer_wallet_balance.php',
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
        data: dio.FormData.fromMap({}),
      );
      walletBalanceModel.value = WalletBalanceModel.fromJson(response['data']);
      DioExceptions.showMessage(Get.context!, response['message']);
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(
                  dioError: e, errorFrom: "GET WALLET BALANCE")
              .errorMessage());
    } finally {
      isLoading(false);
    }
  }

  /// Fetches the transaction history of the user.
  ///
  /// Returns a [Future] that completes with [void].
  Future<void> fetchTransactionHistory() async {
    isLoading.value = true;
    try {
      final response = await dioClient.post(
        '${Config.baseUrl}get_customer_transaction_history.php',
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final List<dynamic>? transactionData = response['data'] as List<dynamic>?;
      final List<TranscationHistoryModel> transactionHistory = transactionData
              ?.map((transaction) => TranscationHistoryModel.fromJson(
                  transaction as Map<String, dynamic>))
              .toList() ??
          <TranscationHistoryModel>[];
      transcationHistoryModel.assignAll(transactionHistory);
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(
                  dioError: e, errorFrom: "GET TRANSACTION HISTORY")
              .errorMessage());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addWalletBalance({
    required String transactionId,
  }) async {
    isLoading.value = false;
    final newBalance = walletBalanceModel.value.customerWallet! +
        int.parse(amountController.text);
    walletBalanceModel.value.customerWallet = newBalance;
    walletBalanceModel.refresh();

    try {
      final response = await dioClient.post(
        '${Config.baseUrl}customer_deposit_to_wallet.php',
        data: dio.FormData.fromMap({
          'transaction_id': transactionId,
          'amount': amountController.text,
          'type': 'deposit',
        }),
        options: dio.Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response != null && response['status'] == true) {
        transcationHistoryModel.insert(
          0,
          TranscationHistoryModel(
            id: 0,
            userId: int.tryParse(userId ?? '0'),
            transactionId: transactionId,
            amount: int.parse(amountController.text),
            type: 'deposit',
          ),
        );
        update();
        DioExceptions.showMessage(Get.context!, response['message']);
      }
    } on dio.DioException catch (e) {
      DioExceptions.showErrorMessage(
          Get.context!,
          DioExceptions.fromDioError(
                  dioError: e, errorFrom: "GET TRANSACTION HISTORY")
              .errorMessage());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  @override
  void onReady() async {
    await Future.wait([
      fetchWalletBalance(),
      fetchTransactionHistory(),
    ]);
    super.onReady();
  }

  @override
  void onClose() {}

  increment() => count.value++;
}
