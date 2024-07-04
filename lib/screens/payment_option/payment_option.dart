import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/constant/app_image.dart';
import 'package:redda_customer/constant/style.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import 'payment_option_controller.dart';

class PaymentOptionScreen extends GetView<PaymentOptionController> {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Payment Options",
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Gap(8),
                Text(
                  "Saved Cards",
                  style: Styles.boldBlack616,
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.ADDNEWCARD);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primary),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add New Card",
                          style: Styles.boldBlue612,
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Image.asset(
                              AppImage.VISA,
                              width: 40,
                            ),
                            Image.asset(
                              AppImage.MASTER_CARD,
                              width: 40,
                            ),
                            Image.asset(
                              AppImage.AMERICAN_EXPRESS,
                              width: 40,
                            ),
                            Image.asset(
                              AppImage.RUPAY,
                              width: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                const Gap(8),
                Text(
                  "Wallet",
                  style: Styles.boldBlack616,
                ),
                const Gap(8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primary),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Card",
                        style: Styles.boldBlue612,
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          Image.asset(
                            AppImage.VISA,
                            width: 40,
                          ),
                          const Gap(6),
                          Text(
                            "Mobikwik",
                            style: Styles.boldBlack612,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            child: Text(
                              "Link Account",
                              style: Styles.boldBlue612,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImage.PAYTM,
                            width: 40,
                          ),
                          const Gap(6),
                          Text(
                            "Paytm Payments Bank Wallet",
                            style: Styles.boldBlack612,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            child: Text(
                              "Link Account",
                              style: Styles.boldBlue612,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImage.VISA,
                            width: 40,
                          ),
                          const Gap(6),
                          Text(
                            "Mobikwik",
                            style: Styles.boldBlack612,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            child: Text(
                              "Link Account",
                              style: Styles.boldBlue612,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImage.PAYTM,
                            width: 40,
                          ),
                          const Gap(6),
                          Text(
                            "Paytm Payments Bank Wallet",
                            style: Styles.boldBlack612,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            child: Text(
                              "Link Account",
                              style: Styles.boldBlue612,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            height: 120,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 4,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Estimated Pick up in 12 mins",
                        style: Styles.boldBlack612,
                      ),
                    ),
                  ],
                ),
                Text(
                  "7.0 kms | Delivery in 40-45 mins",
                  style: Styles.lable414,
                ),
                const Gap(12),
                CustomButton(
                  width: Get.width,
                  height: 35,
                  borderCircular: 6,
                  text: "Checkout",
                  fun: () {
                    Get.toNamed(AppRoutes.ADDNEWCARD);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
