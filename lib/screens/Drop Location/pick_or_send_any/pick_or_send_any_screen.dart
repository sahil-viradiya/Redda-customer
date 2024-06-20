import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:redda_customer/constant/app_color.dart';
import 'package:redda_customer/route/app_route.dart';
import 'package:redda_customer/widget/auth_app_bar_widget.dart';
import 'package:redda_customer/widget/custom_button.dart';
import '../../../constant/app_image.dart';
import '../../../constant/style.dart';
import '../../../widget/location.dart';
import '../../../widget/poly_line.dart';
import 'pick_or_send_any_controller.dart';

class PickOrSendAnyScreen extends GetView<PickOrSendAnyController> {
  const PickOrSendAnyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: appbarSmall1(
          context,
          "Pick up or send Anything",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Gap(16),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Change",
                          style: Styles.boldBlue612,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "       check@gmail.com, varachha, Surat,...",
                    style: Styles.lable411,
                  ),
                  Divider(
                    indent: 20,
                  ),
                  Text(
                    "      John Cane... (+1 98756 23698)",
                    style: Styles.lable411,
                  )
                ],
              ),
            ),
            // _commonVerticalDivider(),
            Gap(8),
            // _commonVerticalDivider(),
            Gap(8),
            //
            // _commonVerticalDivider(),
            // Gap(8), _commonVerticalDivider(),
            // Gap(8),
            // _commonVerticalDivider(),
            // Gap(8),
            //
            // _commonVerticalDivider(),
            // Gap(8),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                        AppImage.ORDER,
                        color: primary,
                      ),
                      const Gap(10),
                      Text(
                        "Deliver to Home",
                        style: Styles.boldBlack612,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Change",
                          style: Styles.boldBlue612,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "       95, Palladium Society, Katargam...",
                    style: Styles.lable411,
                  ),
                  Divider(
                    indent: 20,
                  ),
                  Text(
                    "      John Cane... (+1 98756 23698)",
                    style: Styles.lable411,
                  )
                ],
              ),
            ),
            Gap(38),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Distance -",
                      style: Styles.lable614,
                    ),
                    Text(
                      " 7 Kms",
                      style: Styles.boldBlack614,
                    ),
                    Spacer(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 230,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primary),
                ),
                child: const GetLocationPolyLineScreen(),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     // height: 225,
            //     width: double.infinity,
            //     margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            //     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(color: primary),
            //     ),
            //     child: Column(
            //       children: [
            //         // _commonRow(
            //         //     image: AppImage.INVENTORY,
            //         //     txt: "Avoid sending expensive or fraglie items "),
            //         // const Gap(14),
            //         // _commonRow(
            //         //     image: AppImage.BOX,
            //         //     txt: "Items should fit in a backpack"),
            //         // const Gap(14),
            //         // _commonRow(
            //         //     image: AppImage.NODRINKS,
            //         //     txt: "No alcohol, illegal or restricted items"),
            //         // const Gap(14),
            //         // _commonRow(
            //         //     image: AppImage.WATCH,
            //         //     txt: "Avoid sending expensive or fraglie items"),
            //       ],
            //     ),
            //   ),
            // ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              height: 125,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
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
                  Text(
                    "Estimated Pick up in 12 mins",
                    style: Styles.boldBlack614,
                  ),
                  Gap(6),
                  Text(
                    "7.0 kms | Delivery in 40-45 mins",
                    style: Styles.lable414,
                  ),
                  Gap(6),

                  CustomButton(
                    width: Get.width,
                    height: 35,
                    borderCircular: 6,
                    text: "Checkout",
                    fun: () {
                      Get.toNamed(AppRoutes.CHECKOUT);
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

}
