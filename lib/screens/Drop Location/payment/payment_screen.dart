import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/screens/Drop%20Location/payment/payment_controller.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

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
          ListView(
            children: [
              const Divider(),
              const Gap(10),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Gap(10),
                        SvgPicture.asset(
                          AppImage.PACKAGE,
                          color: primary,
                        ),
                        const Gap(10),
                        Text(
                          "Pick up from check@gmail.com...",
                          style: Styles.boldBlack612,
                        ),
                      ],
                    ),
                    Text(
                      "       check@gmail.com, varachha, Surat,...",
                      style: Styles.lable411,
                    ),
                    const Divider(
                      indent: 20,
                    ),
                    Row(
                      children: [
                        // Gap(10),
                        SvgPicture.asset(
                          AppImage.ORDER,
                          color: primary,
                        ),
                        const Gap(10),
                        Text(
                          "Deliver to Home",
                          style: Styles.boldBlack612,
                        ),
                      ],
                    ),
                    Text(
                      "       95, Palladium Society, Katargam...",
                      style: Styles.lable411,
                    ),
                  ],
                ),
              ),
              const Gap(14),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        "Dlivery in -",
                        style: Styles.lable614,
                      ),
                      Text(
                        " 40-45 mins",
                        style: Styles.boldBlack614,
                      )
                    ],
                  )),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pay by any UPI App",
                      style: Styles.boldBlack616,
                    )),
              ),
              const Gap(14),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Gap(10),
                        Image.asset(
                          AppImage.GOOGLEPAY,
                          // color: primary,
                          height: 50,
                          width: 50,
                        ),
                        const Gap(10),
                        Text(
                          "Google Pay",
                          style: Styles.boldBlack612,
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: primary,
                          value: true,
                          groupValue: 0,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    const Divider(
                      indent: 20,
                    ),
                    Row(
                      children: [
                        // Gap(10),
                        Image.asset(
                          AppImage.PAYTM,
                          // color: primary,
                          height: 50,
                          width: 50,
                        ),
                        const Gap(10),
                        Text(
                          "Paytm",
                          style: Styles.boldBlack612,
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: primary,
                          value: true,
                          groupValue: 0,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    const Divider(
                      indent: 20,
                    ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Add New UPI ID",
                        style: Styles.boldBlue612,
                      ),
                    )
                  ],
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "More Payment Options",
                      style: Styles.boldBlack616,
                    )),
              ),
              const Gap(14),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Gap(10),
                        SvgPicture.asset(
                          AppImage.WALLET,
                          // color: primary,
                          height: 22,
                          width: 22,
                        ),
                        const Gap(22),
                        Text(
                          "Wallets",
                          style: Styles.boldBlack612,
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: primary,
                          value: true,
                          groupValue: 0,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    const Divider(
                      indent: 20,
                    ),
                    Row(
                      children: [
                        const Gap(10),
                        SvgPicture.asset(
                          AppImage.BANK,
                          // color: primary,
                          height: 22,
                          width: 22,
                        ),
                        const Gap(22),
                        Text(
                          "Netbabking",
                          style: Styles.boldBlack612,
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: primary,
                          value: true,
                          groupValue: 0,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height / 2)
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            height: 150,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
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
                        "By confirming, I accept this order doesn’t contain illegal / contraband items.",
                        style: Styles.lable414,
                      ),
                    ),
                    Text(
                      "View T&C.",
                      style: Styles.boldBlue12,
                    ),
                  ],
                ),
                const Gap(6),
                const Gap(6),
                CustomButton(
                  width: Get.width,
                  height: 35,
                  borderCircular: 6,
                  text: "Checkout",
                  fun: () {
                    Get.toNamed(AppRoutes.PAYMENT);
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
