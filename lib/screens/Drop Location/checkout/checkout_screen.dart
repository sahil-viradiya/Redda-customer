import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/app_text_field.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';
import 'checkout_controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: appbarSmall1(
        context,
        "Checkout",
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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

                        Text(
                          "Check",
                          style: Styles.boldBlack612,
                        ),
                        const Gap(6),

                        SvgPicture.asset(
                          AppImage.RIGHTARROW,
                          height: 6,
                          width: 5,
                        ),
                        const Gap(6),

                        Text(
                          "Home",
                          style: Styles.boldBlack612,
                        ),
                        const Spacer(),
                        Text(
                          "Pick UP In",
                          style: Styles.boldBlue12,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Gap(10),

                        Text(
                          "7.0 kms | Delivery in 40-45 mins",
                          style: Styles.lable612,
                        ),

                        const Spacer(),
                        Text(
                          "12 MINS",
                          style: Styles.boldBlue712,
                        ),
                      ],
                    ),
                    const Gap(24),
                    const CustomTextFormFieldWidget(
                      hintText: "Instruction for delivery partner",
                    )
                  ],
                ),
              ),
              const Gap(16),

              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Bill Details",
                      style: Styles.boldBlack616,
                    )),
              ),
              const Gap(16),

              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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

                        Text(
                          "Delivery Fee for 7 kms",
                          style: Styles.noramalBlack416,
                        ),

                        const Spacer(),
                        Text(
                          "\$125",
                          style: Styles.noramalBlack416,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        // Gap(10),

                        Text(
                          "To Pay",
                          style: Styles.boldBlack612,
                        ),

                        const Spacer(),
                        Text(
                          "\$125",
                          style: Styles.noramalBlack416,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(16),

              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Review your order to avoid cancellations",
                      style: Styles.boldBlack616,
                    )),
              ),
              const Gap(16),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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

                        Expanded(
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,  ",
                            style: Styles.noramalBlack416,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Text(
                      "Read Policy",
                      style: Styles.boldBlue715,
                    ),
                  ],

                ),
              ),
              // Spacer(),
              SizedBox(height: Get.height/2)

            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            height: 150,
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
                  text: "Make Payment | \$125",
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
