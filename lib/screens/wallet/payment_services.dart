//rzp_test_GcZZFDPP0jHtC4

import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class PaymentServices {
  initializeRazorpay() {}
  void handlePaymentSuccessResponse(
      PaymentSuccessResponse paymentSuccessResponse) {}
  void handlePaymentFailureResponse(
      PaymentFailureResponse paymentFailureResponse) {}
  void handleWalletResponse(ExternalWalletResponse externalWalletResponse) {}
  void openRazorPaySession(
      int price, String productName, String productdes, String orderId) {}
}
